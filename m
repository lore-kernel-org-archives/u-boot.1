Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D1B606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vVke6r20;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=sr/4+vGs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B94E60677;
	Thu, 22 Oct 2026 14:19:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HYwxga0BedeA; Thu, 22 Oct 2026 14:19:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BA2B16066C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792678762;
	b=prQ+n/2D93ZDmfm50EIXAK4jSFSEafI1gz+H8oLnOtz8eUVtGqWdQMQM1N/lo6kLrgWW
	 U35GTItaM/PNDRVxe5ZGbZKySbpSPE1BkpDnd001YY9+7HSF0Y9pntNaXPifBMWQNNFzc
	 lnFsi2Y/8E+k3fwBXN3OUNqfNdcIxSboveBawhRtAcaJ6ASnoY8JfyAx8Qb88xo5wu5ta
	 e17qe/ORtTvwMOuMLPRJsuTfc6vLdbZqPMhyL54Iy7qVQpSl8moqRP3fBrbnJT4MR5dCw
	 yD3bx/at5+4Wy6egZQidT/2EQQfR3q3K6rUuExP5bPMAJoAPnf6bKaBR/H36RS1LqHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792678762;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=VGzWACq3QaBGTjJPQHVaLSr2UKjVtqmsgwynCsUwfx4=;
	b=qRzUqux6F2MFIGaFkaZMH8yHbZKJyiiMqSgq+bhSIK752Mobqi0uzmzP4cQi9geIVnum
	 l+4biRmxCRT75mBaGzhcYkckaviP+fwVmdrymg19BdrKIlwoyVBiqm8ld/olyV9QSF7dt
	 blJp+6gkn751jSAjVn6KUlz+7HbWeo9aAaBJdEkVTqnl34tti1Nm56dKUjRBKKegS9jLl
	 epXgQBUy55K7aYJvkYxs3PSTdP1njfU0jM6X27GmCpjsXgXMwGJQCkC7FleAcTBVCH3Og
	 eJ2AaJjMQdGnbMquMXzYqaI7oo2uObfMT+e9t1XdzB2BxYKxTy3ezpaPx94lHeZf6TA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792678762;
	bh=VGzWACq3QaBGTjJPQHVaLSr2UKjVtqmsgwynCsUwfx4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vVke6r203HEO1FiakDVI5ZlkF1WtJYwrhFB/BDuEL8VH5qZh+lNioqKL5vRNwhakx
	 2xCDK41KWfMqr1g28mhGS6sHb+XA5LtINXC9z3ifo1UENsY6OV3HTvWtOFfnrx+SaX
	 TzRpnq1GGcC7+HcMF/aAbh1a8fKrD2i1hx/Hk7mlrm3AZySXHqcnQ7DsIDWVU6aUVV
	 +TGKmi7s1WpGeWO6/hl/4jdqEsqrtJNSt2217xaBozI5lkZJB3o/txc/Un0MYYP+Hk
	 oXKu/tHyAXYRYGNjOodfDPgBuZFtT9Oq1eXzDJuTcJ78hozwtKlKRUITq11nl5s4Tb
	 cpbJrnLtIxtnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA2B16066C;
	Thu, 22 Oct 2026 14:19:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 847853AF
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A50080D9F
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e1NrwJRvXl1Q for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 14:19:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9598380D5B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792678760;
 b=PPoIBJk97n0YY5vQQEdlIT046c543toUqRJWm4xwL4pbgXb340JbbAxu0AZp8Cib+NLG
 iyuDZLdbRKbeMQJMea3Cgk8/jAcsDRpnP8UmHdGyh7xd1Lsc11kmwUHSw119WXljs8hgO
 ugg87fujNFU4zUEjv3PwiSR/h5RiuAE0cem/y54Z9mYevB8lJkZCURZvIu4SlUUp8wfLf
 JqOKApo1pCy7wEya1z5WzKwV5sIdiUCBCO8IHv3rWZaNRqkJhCub57ZhYhJSxWo9ozliB
 Mqd5zrT0910R02W7wcDEWH88L6OfBCd1HxDCDY60xY5TYCWhaeS7WMqO1AeKh2TJPpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792678760;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=VGzWACq3QaBGTjJPQHVaLSr2UKjVtqmsgwynCsUwfx4=;
 b=DUa/zifDqIhh8sno59W8EyUsmnwa7T8BAna5jTZYbOfpx8US/XjXYM0mD+YT3R1kdvA6
 NCVXEAS5nSnu9MfdPMG81lX7ISpAXDgN2O5ORpwuS9VDF1ZLJYfqNiu7vNzvmcOXyBgNA
 yjrZ3KE2wafJdKOZAW/eH1+ymihYk2swx163XgnX2zoBY1DnS0RRCtRz2IveWrl7y8KI3
 7FQnXv2f+sgZW51eDLHUitHUWHgy8cCpaCvK3JhzdNKSTl7VYcPj64g/TnnFLnPQXL4/X
 tT1rDnWjRUmY+ppV3w6XbMBsVlJQkTrI1kHfQwngmCnRwPLzxVOJTojVO6PMuuxHoCg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="sr/4+vGs"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=sr/4+vGs
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9598380D5B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:20 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-8446af403b5so1382884a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792678759; x=1793283559;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VGzWACq3QaBGTjJPQHVaLSr2UKjVtqmsgwynCsUwfx4=;
 b=sr/4+vGsbwz/TStR4UdHwV4gvdS38Y2b0MpeyG9Re61/nPcZGOfxZ6dG2l71TFj9TJ
 oGdVg6Zua/AALyj6UJzaPwQ0VxfekD/EjTM9vFN7VJVL6tfBlR97manM7G5YErcgr9at
 hGiJv16TFYF3YHl9wGlAtcKNTIrMZCIcx3ZZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792678759; x=1793283559;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VGzWACq3QaBGTjJPQHVaLSr2UKjVtqmsgwynCsUwfx4=;
 b=Udk3UQre90OFpgq8AO073eNCdJDUoU73zxBdBFw69F/2q48wv/i7OMBRnBf+4Il7zr
 4o9CNjlb7YbS6CCjmyOH3h0hwwnyX8BaOjkE1AWWPAfhOHIuXt+DOfNakKtA6+uR8PeW
 KxwLzxsQMB6Lb9SPFd3EJegCXeKcnKo2hSIE/bQM4UUcguJoGBaQ0+aFirB2k6SSuAlL
 ced3LUImK2KzPQxZs212tJEsMl/7Q7+iwBkYjXtk+spWtLolJN4O3xgZeFNnSPSmu4Ze
 8Gu7zlw8FmdfrqSolrYbN2A42Bs/PwcIwTcY23WBbKD2l7gSZVdbEIcmpGF5PbH78Zmk
 L37w==
X-Gm-Message-State: AFq9FYJOWiVfu09suUoX94VdQCgrv66+ubRtqeP5np8U899EWW8+oc/+
 ICgJIlv5EVsTiKt3cQYa1NH1yIBj03aC9b9c5IGRM6N52p0oUHlgX5JoFG9Pp1ekveQ=
X-Gm-Gg: AYBFou3S5aa/DxFkD/Gq65f12jhXWJyE3HAB2rndDkpXeJwJk07hOEdFmmXVaB1MggK
 LJEYBgNkqQYGDeArEsFYlSnXk0vyrPHAcAUsIVfA+PI/mxhYtWLHDC5IlDdA74K41PO99C6HlIK
 LBTOFEiF6sCdOEwfE2lP6MvwzOlcPSeG6vWwj8Zphh0rh4HeA5dv3r1PKCsdexDMY1nlOvdRSY+
 DYL3lpT41c02UY44MM8Fs9iqzHE/r/jfAA3k4UIwS85TQ0VMR1SbLw4Q6wUn4EvxKkfP/vvfFt8
 ANLBO5BUsaP+yvH125OddxA5kcilVpg2SZjnqaqMMay2KN4hdbzZ3hl6zxQ0jyrFB+IkHLh+u3K
 mNEcrLayRKKqq9o5iWsIRrzvzOV5Q2URewRyvbXnQM83ss/yqKwpryXwkVC2wT/I88QZnlYwMiw
 Yt9gPnix216Hgq1YDDeZstvLHj2rE4qiX/rms+dENGUJutrO3ucb03Q/xYtuzC267aVf29Lv9iq
 phoy1IWV/KeGu3iegX5YOoofcdaR78kYueGgEXLSphKlIwc8NWtVjqlJAxnE4T+TlSEsMb1ub0o
 Y683+fvnm3b2WaZ2y4ZmKQZ7Py2UWNwL1PPc77stvZuzi9qB9ILeAc/7CiMnHOf/QhbinllYMkg
 =
X-Received: by 2002:a05:6830:d05:b0:80c:4d85:9aae with SMTP id
 46e09a7af769-84d07c0e86bmr4470188a34.15.1792678759152; 
 Thu, 22 Oct 2026 07:19:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbd2d2a76sm5506744a34.18.2026.10.22.07.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 07:19:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 =?utf-8?q?Jo=C3=A3o_Loureiro?= <joaofl@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <cover.1791038319.git.joaofl@gmail.com>
References: <cover.1791038319.git.joaofl@gmail.com>
Subject: Re: [PATCH v7 0/3] spi: Introduce driver-model support for SPI EEPROMs
Message-Id: <179267875829.3588521.9140716156957119693.b4-ty@konsulko.com>
Date: Thu, 22 Oct 2026 08:19:18 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 03 Oct 2026 16:45:04 +0200, João Loureiro wrote:

> This series adds a UCLASS_SPI_EEPROM uclass, a driver for AT25-style
> parts, a sandbox emulator and a DM test.
> 
> v7 addresses Simon's review of v6 2/3 and picks up his Reviewed-by on
> patches 1 and 2. Thanks, Simon.
> 
> On the status-register read in probe(): it was diagnostic, not a
> presence check - and on SPI it cannot be one. There is no acknowledge,
> so an unpopulated socket does not make the transfer fail; MISO just
> floats and the read returns 0x00 or 0xff. The only way the read could
> fail is a controller or bus-claim error, and failing probe() for that
> was, as you say, too strong. probe() now ignores a failed read and only
> logs the value at debug level, with a comment saying why. Any real bus
> problem still surfaces on the first spi_eeprom_read().
> 
> [...]

Applied to u-boot/main, thanks!

[1/3] test: dm: sf: Get the emulator attached to the flash slave
      commit: 0d9a51b7e549dbdc688f1a1c408b55c827efe338
[2/3] spi: Introduce initial driver-model support for SPI EEPROMs
      commit: e882a98361facf5fe3c314fc508da265e0d1a004
[3/3] sandbox: spi: Add SPI EEPROM emulator and DM test
      commit: 3b748d780a37592e66b9ecba629834ae9480a3c0
-- 
Tom


