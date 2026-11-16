Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A83606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bsN7SCcW;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=LIdfumUW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56C86405BF;
	Mon, 16 Nov 2026 06:28:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WfbQIgeSztvh; Mon, 16 Nov 2026 06:28:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AD87040620
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794810536;
	b=sqtuPtiaBiAg6UnA99eDu3J2SpSpz8nSpDMRVJJ1JnQn1vWiPJJ74vBeEQo3Rx3yLllu
	 n79GNlPhHRSPHrRypLcj8Q8zUlNMBjwsBwvEmQykFBlObuE3DQz9RPxd+TxCbDrpRhIDT
	 H2fz9xd6EQFqWkNxuv83SCe6uB9BX0TD0ou4A6MwePvBTS6RdeIgqoob5cN1pJbbDTZz/
	 RxcZq4+cg5/tfk5fqqdNNBNJrhXeqS9HNf1yQk5ZgsfJOUdz3yYeSuoNp4FjsFIg6QzM9
	 uGEmPifYqLdKZ5ry83TveoSOT/0l+fMJ9W1hdfaiUdQH/9dQq0fBKvgfew7A4de+yjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794810536;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=F3sAzCdyUmxnqCKaRVuPBo/9pRjckMcgZhmqbj3bA1c=;
	b=IxLAbiMhi9BqtnSqWZrjYUnZZRaIrNRI7NQuyg4y4BnO+Psuve0z5DXT668IKjNCvMiD
	 R+4S7W8cQ16AgP2639sb1IVLffwqt+Dptfi8r1cEh7T3UOdttdhgOFVNO2Ia/fM1EUJgk
	 QG+ugwaglCuoDijNe/p8xYBuSj91OvL0WkKU7y77yQxBV/1HM2zOeTz4g5F/riE8Pb1g2
	 9XWAr0XiY5W8G7oR0PTCXKtuHEaEuFQq0+Vcva/43TGXXfAW/G6xrQOtXGtLWw7DE/Y6I
	 +e0SCM00Ni1tcbFrIipQmRP5Q3SZA80/XMpZFBP5thOnPiar04O9Ke2GMeaFTjVTE4g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=LIdfumUW;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794810536;
	bh=F3sAzCdyUmxnqCKaRVuPBo/9pRjckMcgZhmqbj3bA1c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bsN7SCcWobqREgugO500DcY/VsntqQw3ZDzyjZG1SlFbAACR1KFatv5lu+7+XAN1R
	 JV9SYnzpwo/GKP8XNqI0HLmmfwj3/S8R1ZsGQSVew1ab4J4eVO/uPGLZV2NwxCMOVI
	 ADwD6eHqIucmiib0ylQZ9mSun9oGgWL8+VfFa2xafT5UFO0z4iQz5hRrv5JgC7Kce3
	 gV7QtCdpIHfjwhN+cJppBhe7Z5Iaj7W2pGR/a9iNDpmMSIyhxt4w2y9Q536SLXu9MX
	 kD4XR3AU41CKqkQhiOBHO5GKCYcw+i8/H/qxdyLYnA2Gt5VfOTFobmr8fynF3SmUsO
	 EO/qfdpDEb00Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD87040620;
	Mon, 16 Nov 2026 06:28:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 31A851A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:28:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23A7D4061B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:28:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lOd4uEYmwMjB for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 06:28:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 114B4405BF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=LIdfumUW
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 114B4405BF
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:28:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 59BA610EF40; Mon, 16 Nov 2026 07:28:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1794810527;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=F3sAzCdyUmxnqCKaRVuPBo/9pRjckMcgZhmqbj3bA1c=;
 b=LIdfumUWZfKTc+R3b+sATJ+ThJVe5Sw3WoLjgC0/a00ecm2dtDHVoiqvKdbTbAoUfuAflz
 R/RqLKtF+58152uIr55M5AgDCHHbn6XV1hUJSmtQctqqLBbOXimKPyZU/pjeztCaTn1nnr
 qRIJuOFeniBxD2tJSbj2W4DXvMGfPjngag/Eo/W58qqT4gYxcQRDpk60GDKlmcHJcU33Cn
 9Wnd7OQ7d1b4XcdmyFx3FQI0nymRDUtuWMEefYjoi2OZ1KMhB9kmx4rqeYAIc+YT4kMErr
 /98wOpyIVp8XTlhh6pKZYEmta+AIWzESbuHEvnhEpumYDY+us8zS9ApZGiIh6g==
Message-ID: <833a7652-9b2e-84ec-e4d5-af5f7d3a18c0@nabladev.com>
Date: Mon, 16 Nov 2026 07:28:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] i2c: geni: do not report a missing clock disable
 operation
Content-Language: en-US
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
References: <20261115-qcom-geni-mixed-minicore-v1-0-bce20aa8f4cf@oss.qualcomm.com>
 <20261115-qcom-geni-mixed-minicore-v1-2-bce20aa8f4cf@oss.qualcomm.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20261115-qcom-geni-mixed-minicore-v1-2-bce20aa8f4cf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Igor,

On 15.11.26 11:49, Igor Opaniuk wrote:
> clk_disable() returns -ENOSYS when the clock driver has no disable
> operation, as with the Qualcomm clock drivers, so the probe error path
> prints "clk_disable se failed -38" although nothing failed. Ignore
> -ENOSYS, as clk_disable_bulk() does.
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
>   drivers/i2c/geni_i2c.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
