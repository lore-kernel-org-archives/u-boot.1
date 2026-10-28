Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED41E606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qgXrry1X;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=RfAyIyfv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4A7981111;
	Wed, 28 Oct 2026 14:54:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dWLRgR6L32qA; Wed, 28 Oct 2026 14:54:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 07C8781108
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793199290;
	b=LOAhRbw8/CUtStO7jvLMPMsnowWV9iCOYrB564HttBZ4asLLttgNv4aIbswLXoOGtlbB
	 tXccYGT3N5iy/BTeGcig4qleAqSzaG4GpgAphllGkH4dZO3MJypplvLkDGT2DgFhTsDJU
	 qQwIy0XYs1jDEzvG05MJtVEHqH5Qv9PzY8FZJ5NeLlmo4zzMvIkl47IFFyzPOQXrlWlb7
	 laXuz5AoIPmFcLRO7TLng55vlIA0WZ0bt/JpXWWK94v/WOMhnxaXBtrvgxUM8sSwWcrDz
	 1ty0prQ9a4IJ+6LqGp0hBoXbZXgKwbrhmgPxfkm0X31yeNj8o7P98+kS3Dt6EOCTwnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793199290;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dB+B2SqVmOyet+pRDybzduypnxzmQR+5Z/o67/ZLzjI=;
	b=G5nK8cjyZLUYdEsyCs463lnylcmq+2i6FhiY+eM909FuduB8PEUqtMaUw4uNpCMFDLwN
	 HF9VDoMnygRaKv1g34ofcB53U9MHIYd8sGVX5huw/jt92ZOJtZyeLukIM4jlzlLXPSxgL
	 Sv2vWQajQZBGaOqCglpsFAuVcx94SwC6I2a7t9oGV8uxpJKu7fpyJP7GxrIcOYaFaMo80
	 HgGYBMamcFv9LXa07Jnjn8Ey30REngvNAsVrurgkQ/Hn/KdgJ5nhKnnLDzARzqtoHh4ib
	 Q1zAShPSeVeQIRODSnB3Vfd7YxLqHKivmJ07dA3OtgpfgZzLCY26VxLAbDx/WkW46cA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793199290;
	bh=dB+B2SqVmOyet+pRDybzduypnxzmQR+5Z/o67/ZLzjI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qgXrry1Xl+qrM+6j2R1fAtFpE27rrvhrPusIdA8IaHHYY0jmiqVIeJWFMv5XwBIrD
	 UewLN6ZUUGPg44wbSa4FRcAY/+CmWImJ5mPqHNMIta+2SXGhCJhUYG9mDzISmO6fQp
	 UzickKc/pyoYf/kaS+yYHsoNnPerfdPzhjLrbYDSo37KrXTtLO7EmI14nVBNurW8/K
	 ucYeUC3eCQw9y8GXW8iOeTxmQyQEdZj2QyIVHugUGWXa9qcPt5UtAm5lHy8VyyrlHX
	 L25DpmmA1A743S3ayWqof+9MD2s6USUlWQv4EOFKrKKDAU5TXK+lSPVV4Kxk11nBkL
	 k7UdQJ98AxB5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07C8781108;
	Wed, 28 Oct 2026 14:54:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BB154D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:54:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C3CE240740
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:54:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m3q4uVXwAxCK for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:54:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1363D4054B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793199279;
 b=Bc4+OmiKO5G8NEDVI7Bf7m/99r4hsahvFOsX3y7LzyDDTMy9IbOCkvYkqe+U8GFcycAm
 rh0sutArh+283q+EccPfAaSyrxH7gzi4KiU1YsgX48OqUPNyUScnthXkp30+1+3j6ZXwV
 DXhi6ngOFncdk3EDpI/B8RwNRKBlfcanq/S6DcQ44iJGzUx9h1Kw2jL+2dSQaebOr7Ok0
 PfxcqBHMAvdIymwJrgMTBrib/L0P0+5DAmLFYmXmz+KwYQ2hlMxUwVYMxmTBbTqtETq7V
 u4mxGLDYteAFUmNLLYV25p8faYYthfhEkGqbg/N/M97gbKuyZE0Mz+M+alb0s03I8MA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793199279;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=dB+B2SqVmOyet+pRDybzduypnxzmQR+5Z/o67/ZLzjI=;
 b=KBzVhBXm/s0vfES8EHl6wWJ0Up8wcvkjvRsdrbunZjcdTNB5rqGzQvx/2cHLyB0Ss2Mk
 ySLgj546aFhXZHkmYIcXmMnObTUVUfLToaFAP5Cj3ZiK6TU08AE5Nuheb4kz/MJ9oQQ1Z
 4Alw3tC7rWx6sDoBZmQYWDL4vFtuRrqzodSJeYrG8ZDliXPYwPM8jCB/61iLvhKmo2OyN
 R/nQLDpVKLVdIzJEy1Q8LZhdeu9XXRjFsEB3n7xY2U3qewjykcKhWIw4HQvl5f7Kryhvf
 n00RmZ3Ceor84+cGSqcoeLqK4Cq/mS5c24kM3gc5SthA+ug5dSHWyQUr/DIwR5zWjPA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RfAyIyfv; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RfAyIyfv
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1363D4054B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:54:38 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-8253bc5a613so710853a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793199278; x=1793804078;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dB+B2SqVmOyet+pRDybzduypnxzmQR+5Z/o67/ZLzjI=;
 b=RfAyIyfvwxXip3SJRGarPnS3bw3ScUMBFJeYfiLJJJ9A2pozPKne/kQtbO2eLgmqk0
 vUEFUo9gfbFxQflswd19UWbmY+dhxOqsy2DRGoVN97Kr8aU1+LSWLLDff4QBAdDCxNI+
 ngmK9XoksPvGqzpPjlFJcUtJy5Gb02YY7Qv80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793199278; x=1793804078;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dB+B2SqVmOyet+pRDybzduypnxzmQR+5Z/o67/ZLzjI=;
 b=M2rZmZ0/d4UlG2qa0IJGHSm4SKBTWNK16Vq1ks9/l3z6BfYX/f2qdQZF7VJ8wSOilW
 EEzrDCF2Nb99iOxTwP3kEhZj4WomqgN32Lo8nVl+8qV86I524ilwHRJP7Tqcz3fLygw/
 yZ+2ynMfGBTeskFHMerPhJtO4cJ1qmApVJExKOhLZiHOrWw5tJ5GPniUoxBneZh7Fgdr
 X1NTGCzHYh8PgtRfP5Wz5JXKkMUUfUN0zxjNIdMMQZARpaUF2ZeJH9mIczXjdx4LrKoN
 xVmSB8vEJbU6n+oU1UcTqTQ+vjpmNDV7egHgfLJWuUfWdmpdrfDUFPwQtiG0eRQj/KYD
 WTcg==
X-Gm-Message-State: AFq9FYJPUicwsqIwU0Vwqu+24tLt+stuKyb8AsR4FM4LAILmjNZmTI79
 Ll9gC/M9HX2dWn26gD22ck95glq6Mr3cPbMzM4o9Tn/0AkAlCJcoMRAFm0rZ1ley1fA=
X-Gm-Gg: AYBFou0HOfCHG7yqF0nhtNG7Eda8OSMzRWAUfnOc2VblEMPv/5URGqXodQTmlrE2cb6
 lHIr+XU8lysORTkDfEwFLE/tKKmt1YMfgPuVa1phcdbpQBpWQxbv/qTzgIG4BWLSqrtrankca4e
 jDPDrsSoliKbnAHDjZTfwvks7qdpWB5OBpBV4Y2gx5yfV4RnIY2BRgl6LlLCmrLK894rw+z2zmj
 REFA3+IF8Jmfwo+0luylX26j23aSijX0L+7dL/bsIeoYSmxe/So0XPTIWtQE26foXPvb8dz4g2z
 DPw6be0P/JxX/hZVeRuk+dWYf7hQ7LM7cr4xr6fXs3aQqmlJ9vMFyVBLbzblNMuNW0OvHMVFab9
 2uXZthDMuM72W7ElPqVfbYcJozIan6q9WNpDcLUX5oTD1Wnt/6Ocp0sz+kJJF74ILpQujaCIZKS
 HgELAsXjhnXABk5PRHKUzXwW+BQdNYSUdzuiMdQasNjeYNP7nF7+eKGhxISQJaUwxtTd0tQp7sP
 Uwep3NVvtf3GzluiV1Nbqahy91zJkW8HkKTQZLxT2TyEzHqUxT4ySpi8QLag1epbPhrFfwweh0v
 PwDy4TXtsiRn7hSmBAaZbI7WyEPpRgmV5/5pmRi8smDwWD69DHjQwlLEIL/LnIqL/8k8cMBQuCJ
 ubl2Wl5sbvCyhgfIrlk4DLv95F+Ey/2IKKJRXm2IoEpG1GXGW40drWVxhvgS3Na9MDwKCjSQaBW
 4iOBvtojygUczodHUNRCZ2+zs58krtqg==
X-Received: by 2002:a05:6830:2546:b0:81c:b7d6:e6eb with SMTP id
 46e09a7af769-85ab7040761mr2389006a34.7.1793199277819; 
 Wed, 28 Oct 2026 07:54:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b20217c77sm1871528a34.21.2026.10.28.07.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:54:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Petr Hodina <petr.hodina@protonmail.com>
Cc: David Heidelberg <david@ixit.cz>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20261013-b4-button-adc-get-code-v2-1-72a1352d5965@protonmail.com>
References: <20261013-b4-button-adc-get-code-v2-1-72a1352d5965@protonmail.com>
Subject: Re: [PATCH v2] button: adc: implement get_code()
Message-Id: <179319927656.2677777.11517326901744188888.b4-ty@konsulko.com>
Date: Wed, 28 Oct 2026 08:54:36 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Tue, 13 Oct 2026 18:13:23 +0200, Petr Hodina wrote:

> Implement .get_code in button_adc_ops and add linux_code
> to button_adc_priv.
> 
> The consumer in this case is the PinePhone Pro platform with the
> volume up and down keys for selection in bootmenu.
> 
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] button: adc: implement get_code()
      commit: 2899fc52dcf58849b51ccd140641bc523fb7e033
-- 
Tom


