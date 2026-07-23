Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA031C531CC
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 21:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5655160AEF;
	Thu, 23 Jul 2026 21:01:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HnoWjsrSCLwm; Thu, 23 Jul 2026 21:01:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4838060AD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784840513;
	bh=cZ2QdSTj+KNZdUvd6PXhRDblcytfFugECWhzxdGMo0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oa5TE7zMiMN26n19qT90Oe6UKKhb87rdLuA+m2piwYhtxE+LugdDXtlMDrsRwKSuk
	 c8eIZLaNafsD2bZxrHzZRUHJdixo5YCYd66uaZw42p9dECAgRFVco3tpjdUE3TDO9j
	 Z0oxa9pHAt0fAd3caGLR7zZzKxDbK0aYQdA7PLV5JKcWK/jrhyP+0l+Srzilz4oHim
	 g2YP5ubqNtrljjAeXGQDAMLCp/KQG0/C5B/Shy/+dzBSlL83USqt1yOIw+AgDzLc+f
	 kb80uAXLgx0EiLnxsI6XIrRoXnLlBibsgSrtbv2ssxawyu3LDaXkDG7xb5aL4V+uuH
	 N5MsZMC3I39OA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4838060AD5;
	Thu, 23 Jul 2026 21:01:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 46C65707
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 21:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C57A60AD5
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 21:01:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zTt4_i4apzbY for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 21:01:51 +0000 (UTC)
X-Greylist: delayed 338 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 23 Jul 2026 21:01:50 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BBF2D60873
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BBF2D60873
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:1004:224b::b2; helo=out-178.mta0.migadu.com;
 envelope-from=funderscore@postmarketos.org; receiver=<UNKNOWN> 
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BBF2D60873
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 21:01:50 +0000 (UTC)
Date: Thu, 23 Jul 2026 20:52:26 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-qcom@groups.io,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: Re: [PATCH 1/7] qcom: capsule: add FIT capsule support with
 multi-partition
References: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
 <a4b3eeed-0789-4bec-b29f-d13e3e3b3016@oss.qualcomm.com>
 <CAC_iWjLQxOVb7H-Mib7NAYLmzumhL5uBi8dZ_ufCksJMrcQ8OQ@mail.gmail.com>
 <89329f38-d2c5-4014-a1e1-44ccfd09b3bd@linaro.org>
 <242ab545-c274-4b65-afa9-2c3ab056a918@oss.qualcomm.com>
 <CAC_iWjK_U_TtNJsXjgVggXa28iHb9212tEQEdQn8wK2XqXmJiQ@mail.gmail.com>
 <19959cc3-40f6-4e9e-801d-8f7c40edbf70@oss.qualcomm.com>
 <CAC_iWjJSNekv73X0n3G-qPjh60F88R=CHybxHzBUo1DDgGzrqg@mail.gmail.com>
 <37b24004-5080-43cd-923d-8db6d09f40ed@oss.qualcomm.com>
 <CAC_iWj+yLvqqunA_j6WX_0v_DSkf6xwXPSL+kysrUM7G3isSKw@mail.gmail.com>
 <8de79ca7-e826-4a61-b380-2bdf01c39871@oss.qualcomm.com>
 <4b344c4d-ef0e-4595-a6ff-10629cfaaa82@linaro.org>
 <936f99e6-bd6f-4168-bfea-8a8c777b4c52@oss.qualcomm.com>
 <6748951d-d720-46bd-82bd-19c4d97a6f20@linaro.org>
 <73fa32f5-0d10-4f95-a02f-2cac91d072d6@oss.qualcomm.com>
 <013d5bbc-983e-4386-b236-8c63f4406fc0@linaro.org>
 <aaeb155a-6195-4574-b4b4-fa7d6a88a00f@oss.qualcomm.com> <20feda0
 9-ab10-43e4-831b-6a8647f5c62e@linaro.org>
 <tin7mt.2xum2ewhgltm7@postmarketos.org>
In-Reply-To: <tin7mt.2xum2ewhgltm7@postmarketos.org>
Message-ID: <tinbh7.cnq1zhtzztno@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=postmarketos.org; s=key1; t=1784840164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZ2QdSTj+KNZdUvd6PXhRDblcytfFugECWhzxdGMo0Y=;
 b=CM1ZVx2RHer8G4bbivqpNFcoiJmz39abt3eLdWhqm76nxksEZ9MDkRbahTL8C24wiknFnK
 i8/o+PXMcESqI6LwAM2Q+vuloEf4SiDUPtjmlcEDVn69yiYF5Vaqi4ky3DZ2mPh2knhr+4
 Mxl4HeR5tKaLfDXjue96TAbprZVZ8ELIlZzDYyXhEezMrb65nuQOs/qTXDsZgvxDDe45Ue
 mSCUyY1eJkqUspLcq29MSn3vShQYZQcT7cAXz5k0Qu6CRX6y1Nc8OXu/zuMwgbEIhGVX5i
 L9LZg93gVm2lGUzoyDQR3n1xscQYxGopmuzRUqD+BHD8202pmzSPkMvYdy8U+A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=fail reason="signature verification failed" (2048-bit key,
 unprotected) header.d=postmarketos.org header.i=@postmarketos.org
 header.a=rsa-sha256 header.s=key1 header.b=CM1ZVx2R
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

(It seems I sent to the wrong mailing list, what I wanted to send is below)

On Thu, 23 Jul 2026 19:07, "Casey Connolly via groups.io" <casey.connolly=linaro.org@groups.io> wrote:
><...>
>> I feel we are complicating it by trying to go for dynamic fw_images.  
>> 
>> Rather than introducing a solution that diverges from the UEFI
>> specification, shall we use a board-specific static fw_images[]
>
>Well, the solution I proposed at the end very much doesn't diverge from
>the spec, that was kinda the point.
>
>> definition. This approach is simpler, remains spec-compliant, and other
>
>Simpler for you to implement or simpler to maintain? I think that's
>quite debatable...
>
>> vendors (like NXP, TI) have also implemented static fw_images (in board/
>> nxp, board/ti).
>

It is worth noting that mach-snapdragon isn't the only one using dynamic
fw_images[], Amlogic has also been switched to that approach too, while
previously hardcoding them per-board (mostly was only done for Libre Computer
boards with an SPI flash). On Amlogic side though we just use one giant image
with U-Boot and all the other bootloader stages before it, though with
U-Boot SPL enabled on GX SoCs this image contains a U-Boot SPL binary and
embedded FIT image containing everything else.

It really does make it much easier to bring capsule updates easily everywhere
and I think its advantages will become more appealing to other maintainers
over time. But just saying, Qualcomm boards are not alone doing this :)

Best regards,
Ferass
