Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0734C606A31A
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OPkSnnIl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=Ijcu91QV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C80AE80DE7;
	Sun,  8 Nov 2026 02:00:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2x2vGIhvX6Ix; Sun,  8 Nov 2026 02:00:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D26B780DBB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794103209;
	b=CnZDBjsWZO0+UF3H6Kv18SjSBLRx/jehEx4tJ0DEMq3yCR+vyVkbhs6BLvoIWEgM9wrf
	 4Pv3ebxtYxPOJGwg0OTY66TUEQzLBWhh+DVtRDSfloDIAuwwU3BgN5eq/L65Sl41/4bnI
	 jeBQCG7wNnPtZ3FPKJ/VeQtzy3tPc0H6K/IorhkKMYARdWvPDYo/S63dowi6U/1YLmm6i
	 UV6RBhbOhXf+2vDAFD9+Rw09xnTEOtIkO4Cr1RxipSD5SKL+w/E8AJ6YpL7u+1bgckDqh
	 2HnHnMaGlHFD3NcJXokeF0gGbqdqAlYPb1LJ3V7+BB2RsP5TFYf0SGSNle78hBGVurA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794103209;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RZIlEaAqWPfo27QQahbw/HKRJPavbJeuISmGiSfC88o=;
	b=B3fAaRgmdXRoUNrX0L+rqiLzLK04m2viW/Kp/qZIfNGlcu9zWj5p3x/ib/fcUPbuVVrq
	 2Yjpp0kTU7jVkD9UXglq/+1yY6MGYWPTXARZkQRKh1BCa8OLdGjNADFBMvCj/sZgnmrQK
	 hXXj5xsP+8tKjBdP4zspOVBjnz6lASEfrrrJXGLygSAZabgWabSY3EqLJAk711EQrWPTA
	 lLP2ypuYufFw2D1qc0WUy9DwFNaGpW4bM/wxfRolIzo64GCVQ0NLWPfjo6DbVnlQTt92z
	 ATCkEz1YSexB67Ws+YGYsjdRT6hvVHo8JjagWyA3OqFmH1YnPUF/toR9ZmV4BJzFp2Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794103209;
	bh=RZIlEaAqWPfo27QQahbw/HKRJPavbJeuISmGiSfC88o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OPkSnnIlS8flWcpb1mGOhviTklgN31vlMqRmKvHGcjNzszhA/VUtDesLubZGJG76r
	 bAPp1s15mr6NmWDZpRTlX+zcR3PLzq12oA1Zx9cn34RIle+eSge0kFRtTFKwYiLyss
	 It3Azicilh/ZgafUYj9N1SdycqghZhEjp28e0GR/kTL/BtzMhzzutfox2A48m/NxNG
	 oopQH6pldeW0n0b7xn6YSU/8RFjNqh+DBOYtaZq6YoBvw5OHuJVp+5mRHyqAB6tuU1
	 /81E0od1rfanOV6S3HvD8C7K322MLFkKHHhgmaqRbNXvWKi19ugAGNoLlFgm46ns7+
	 xAd6+NfRTjGzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D26B780DBB;
	Sun,  8 Nov 2026 02:00:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BB4C32A
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 02:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 13E56605E3
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 02:00:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sBI50U489noy for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 02:00:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C9378605DE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.169.17
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.169.17;
 helo=sender-op-o17.zoho.eu; envelope-from=iav@iav.lv; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256
 header.s=zoho header.b=Ijcu91QV
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C9378605DE
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 02:00:03 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=Ijcu91QV8G6M+LnRx1hUGM8Hb7m8/RvjsXTU4/eCeJ/MDGc5FLkJGJyf5GDo9wjB3BH8YLMO5skQCtddxjQbsmwHAvJ4D6mVJIEO3QzpYZVBdZAQUGDusR6EyZyaY/9Gd05if73caU9kcQsz9SaIzeIIhp/QSAlq4VxyWOXAE48=;
 c=relaxed/relaxed; s=zoho; d=iav.lv; v=1;
 bh=RZIlEaAqWPfo27QQahbw/HKRJPavbJeuISmGiSfC88o=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1794103193783134.4969865929861;
 Sun, 8 Nov 2026 02:59:53 +0100 (CET)
Date: Sun, 08 Nov 2026 03:59:52 +0200
From: Igor Velkov <iav@iav.lv>
To: E Shattow <e@freeshell.de>, Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org,
 Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH 0/4] cmd: lwip: wget: write the download to a block device
Message-ID: <20261108-re-shattow-wget-blk-cc@iav.lv>
In-Reply-To: <896494fe-261b-442b-91a5-25333371c8d0@freeshell.de>
References: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
 <3bb5a9a4-ce05-45c8-9fc4-d4fe99b1b0c1@arm.com>
 <79fdb1d0-c777-43c4-a7ea-98455186e900@freeshell.de>
 <2b5d3f92-666f-4c0b-863e-c681674c611c@arm.com>
 <20261107-re-jerome-shattow-wget-blk-0@iav.lv>
 <896494fe-261b-442b-91a5-25333371c8d0@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi E,

Thanks for writing it up. I won't take on 'cc': driving existing commands
by rewriting their arguments needs an adapter and chunk arithmetic for
each of them, and I don't see how to make that reliable. That is more
than I can do well.

I'd rather finish wget -o: v2 with Heinrich's comments, with the options
in whatever form the maintainers prefer. The block-device writer stays a
separate sink, so a 'cc' could use it later.

Igor
