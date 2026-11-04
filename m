Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0E9606A33D
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MdM1s1Bz;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+UkGbhW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E832741761;
	Wed,  4 Nov 2026 16:16:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nn0XiUGLVwVr; Wed,  4 Nov 2026 16:16:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C56104F7F5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793808156;
	b=EpmBYrRCRtxwUFwENfmXaaWh2SkFkZdLKYn+B5hAc2NvdNTfenOQ/bJ73Q/FIyfLVAYD
	 0nPmWz5bAFloClCURFZglv0AnagucepZTZJ16Vos6kxsOGO37daVV4uwRxvp1HbBTql4o
	 uuZBjws/dTbG6VeFPClYp0E8KAaWtp8egeVVP8iHw3+A48nN6XcPoEprcdDGTBaq9S2Fi
	 NcO68o+8giF9gQddP/zKZXVNFXi6/tWgX+yAoNygSOr5RlT69e7VQW+fCsQQc21XtTSBt
	 diasLUQGVnRT6c1gVv9GAqkEEybwD0JcgV162MWg92pikZrTnrPsLhbf+e4Jm2DJJEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793808156;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=82OOR6XOaBk5JbRFgEZAHvDe7CYANYANfbOCLVz9hGw=;
	b=lfw2ep47iJTr2lFeMgqXW2al9aTywZYl6Nqr3ImvvGo7wF6w0vJ31PzHFJjMzxyICg9E
	 Xkdz+ZPO4Tz6rZJXCQdlePVDELHOpvqSjPqzhxLKSrGaob5vsV5Ve5mw1rljroZAx0cJZ
	 avm49ibYSKo6wovSvBcIOXi087mtYEB77znI6pkLvFP5sueFRjAZi69ldL/xEui+X1zBr
	 aWQH9U51jjUb2QyNuXm5Pp5SLmAPrieFkEJkMItCkI9BOUvnEwXTK4y4zTvp0j27Vrs5j
	 180Q0bw4LCGgBQOD8hut671eeRFfwNHUvhF+BUBW//CS3zo1tiqEwVg94sIH8giF/YA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793808156;
	bh=82OOR6XOaBk5JbRFgEZAHvDe7CYANYANfbOCLVz9hGw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MdM1s1Bz9TBRGhFUOZ8AnZSEDccMBQsp1IimDsG5RCG792b84hBtcslD6o3ClcwOc
	 nh65T94zAxpJjv7Zmu2WtwpVGyd8+yErH9vAxMPDpy7l3L/6/KoXnZh5M9zkar74sM
	 rGCezhZPgHSxzOUbwHd7rBf2UTcd1IBiIuGQme3wBXU50MiuCq3DCPSJscs4I9JypI
	 LkMaApbUlNlrD+gT9gI3sF3eyRK9s7OqEKw8mYlIazmYOiKcR7yZPDovf+lEfeJEmy
	 gQkSgS/s7kkOra7zqc7dsHobfR4WZqyOdFQihnLDP4JKehNv0DQH3I3jM0y2cvu8er
	 LNKzulIxzwSRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C56104F7F5;
	Wed,  4 Nov 2026 16:02:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 31635362
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2ED6D80931
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:02:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8RYZ8NGg48GX for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:02:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 790D5808D1
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793808154;
 b=Zz2N/4qiz6WPo2mZ8z8ILMw4GSkRPWMSGiG8MjXWOe7JTGddd2/5wANUiZV1uI3N+fR+
 vMOikXq7k4gSrT5E15yMcEmpRF11iVRgPvRsbqCqhy4RvLOEQLKbiJI/7AEEysm/d+D6G
 BToDpSSmQv9hbzbF6U9f5qEHEq6PLMQr/rkkfZMVRFstg7azN7SBXyAtmpqafarB3zmPu
 HyGYl2bDvcrPEGyXakNlP6BPsWn8/SEvx09evu76KW0qpvogIiwA45rKHKv8yQVZkGYfO
 hu9vCT7Y2K6RTQzUWTSMdRZKeoQYnDCd//H8jyAkYV6sbBT9FKFwUv8oNuR9y0oUCdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793808154;
 h=Received-SPF:Received:Received:DKIM-Signature:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=82OOR6XOaBk5JbRFgEZAHvDe7CYANYANfbOCLVz9hGw=;
 b=eV2mz3oN2tdjPpQ7DejVnNTquUmxGU3qIVipyM0uQg/Ci+SsNCBt4aDvKLzb8aYHgZy3
 1RMnbvStfQFvmlsFby9zxERUdlh+e/7oKpyCa+N3lJblGKzrIcvN6OBwjHaAuj+X69sSh
 UvkyCbUl2xIwZ0tkSYrP6ga022ZU73iopAa1E6K5gHyR31naAaZ58Gu/y+sA1QL6YLvZP
 SOwi7eXGcRrHdjpsUqy/+dhwxKJTSVMdJ3xOCCPvA++M4tM21a9bjRHNfJwYCJ0hxm7tk
 vOvinRD8RkmSUT0nyeZJM9HRU3yQSNZ1g+K44DTov0B3M2HIWNXbv8CcsMvjcoX8H8w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=R+UkGbhW; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=R+UkGbhW
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 790D5808D1
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:02:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F1BB9406C5;
 Wed,  4 Nov 2026 16:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6571F000C1;
 Wed,  4 Nov 2026 16:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793808152;
 bh=82OOR6XOaBk5JbRFgEZAHvDe7CYANYANfbOCLVz9hGw=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=R+UkGbhWNiVNMYZfXVMMTEucSKU2sD1EeJoa8PjX8jAqrI4k45Arlt6Rc4ISZ7Tkc
 Elm8mkAAd+jklXSBOqXvFqtmbKPfviajihFWbKjf5kPbWsacBK7j3ARhz/znlllHFO
 bukxA6HtgZqsJq5rA9hldxya0ofHiDcjZEDavmOO7jKvN0G5bbJIEKODmCOjcodvmt
 dUhY4eLBaIhdg44FQ3NxDbff2/MRnL4MXXz4m/6f+XsWCoa4kZQddPU/Z9uurraX7z
 gfenQnhmIQMkSW8n7tdlG67f0tqG/3nJy8sBREsV654EXkkK3br6xM/0egNUFQwHcc
 HB4MmcVUw4/KA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] usb: dwc3: gadget: make Set Endpoint Configuration
 macros safe
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>
In-Reply-To: <20261102-dwc3-depcfg-macros-v1-1-0def219ced9c@oss.qualcomm.com>
References: <20261102-dwc3-depcfg-macros-v1-1-0def219ced9c@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 17:02:28 +0100
Message-Id: <179380814804.766638.1485829318729658104.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=796;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=6DDY5GM8H5qQOrWCws4+PZ6H0giYEsXyaER2Ruezu2w=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq61cWrD2rNgyok0lCORfmw5p1sviMiPvs7d78a
 +1pu9wDMHqJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCautXFgAKCRAZDR20Zk4Z
 NQcuB/4raKq/pc6nQa5TGPd7XUGjXQ9anodZE2DHWFoCl2OH7GvwohiYf+oK+OnYMq0wuFD5BM0
 W0aF7zdR8UXaLddT7FKGyrRzpax0MmbPeGT94dR182bRQ0+vew+CTHZgMrK11hB5PGTFJsuHtn1
 gTr62pGJjXBg7FPiMpcnbjA6d3vAIJHvkFcTX/65Zw49dAbnftdd4Y1MQHCz3CVTF0TmR8E1ddY
 gCqnQFTCxamZiVs1UEuUGg8r7oPn2rwzvzEyd4ZO9WCuGLUixuXPXLmXjkmNF0gj2n5/0S7eIiX
 Tlm5rkAeWentzjORLEQ+RrXBNJf/RSTYN83tuMOD0B2sDeZI
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 02 Nov 2026 10:11:47 +0100, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> The DEPCFG field macros shift their argument without masking it, so an
> out-of-range value spills into the neighbouring fields. This happens
> on every SuperSpeed bulk endpoint: no gadget function sets
> usb_ep.maxburst, dwc3_gadget_set_ep_config() programs maxburst - 1 =
> 0xffffffff as the burst size, and DWC3_DEPCFG_BURST_SIZE() sets bits
> 31:22 of parameter 0 - the data sequence number and the configuration
> action as well as the burst size. The fastboot bulk-out endpoint, for
> example, is configured with parameter 0 0xffc02004 instead of
> 0x03c02004.
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
