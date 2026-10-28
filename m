Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C786A606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BTjN6vTp;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kvAYHq9i
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51EAE8110C;
	Wed, 28 Oct 2026 16:01:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0RW_JLU8g67Q; Wed, 28 Oct 2026 16:01:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 61F5581161
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793203312;
	b=TVv2gE4Wzx0jIsqthG/0psPMOvkb1bCDT2uk4ve0S3lX6BovVbOxsjsbErdGpu4Q0IS9
	 JWDvAc+8xnXMuTNHqcYKEvVpSWe6nzriLV6UmKxSNOBat90cS84CBeBOpYaOIAYCNArcn
	 balX0NII9qYjzHole5HOvqDLcgXGpTZAIXlIwQqI4NpGL8KqW181b1krtuN/hJITMpDdM
	 3sVgG0pis7Sor3MYy7ocwoWSqIBO/yfIFdspQDqrxMhbaPPHQBkX3Y4O/xvrzzv5oY8vi
	 7kS/4g0PIMOCwo/+1Smmi31wbyYSSQLWQx1phHU8GLOGmdnYfLYdwK5sDCBK5PaSfDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793203312;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=naOIatMRZmrDAx/x9523dVP3OThUFKzZDqOgk9kTf2k=;
	b=MFl/atyAPXAMxfloRtnJCz7FeZIMasJK1aGyjNw+oZi/Hxw5uc+898QceMRKjiNicbSL
	 y0OjGsFRwi9aT25EPHfuHCZkEW56w5M2PRnSkv0Q5ZA0tSQGZlM7nvJjphR0zAhCGQZBp
	 AI+7RbrcPvurVunDqqi9ZWPBgiDGkVbMQlC43ZKe/2A+BnojUp6UZifAOMULjFhNGeH+n
	 CxTBtvSppwF4jPNTGeRqOg3ORBSKvZ88N7cFAJZB4rvhqVSlje1dsXjvc7woMqZujwDme
	 2NfWzxdqA21NwFASwYtzjZwtggzZWrjU+u8SuJOkS1uzg2qQ91wxkWOkeOC+FFTuPdg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793203312;
	bh=naOIatMRZmrDAx/x9523dVP3OThUFKzZDqOgk9kTf2k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BTjN6vTpDiEhYIqUMPW2L6KZ/z+jxpF8d+bF80Sr6ZEEL8TB50TmejdD5bFsC9jMd
	 1524kDTqVp1s+kpzY+ECaC82dE99+2iN2By815fO6vVNIf6lDJJYBeqj08C9gjAaEZ
	 fBue7dsZ+zIPqaMuLMnWfxAtLuYxZwarmVwHpXPbuAfoOd5iS24g7oFXRsKYzCw5AT
	 Hdg0ovLUlBe+rtP+FoOQphxikfgLkHuyqYJUNaInWDMW5erJQMTvZVvgBe1zLTylKN
	 WwmkIVTINBw5falfOV4Zmk47eQzU2Rrk1ohEMKOp4wEWff5Ia2KWYuyR8FEUDPZs36
	 O8qLeeG0g2vlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61F5581161;
	Wed, 28 Oct 2026 16:01:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D8764D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5328640536
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0g_RZuerW_do for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 16:01:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B495040533
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793203306;
 b=GGbA9q6Vuc6v7t4i5e/skdu8aKfyYtZ9iZFPiSyaHc/P+ncTwZV/jCAzQCdTYfvmtUhZ
 THSwbACBDz941udUnkwBcU7wo7sn0CW21ODMmaBnlDduVbh72yPUrdmQaRg+GYUzIFFBL
 SWeaPIxuWYhOSi2h3MQd5TxNGkSPKqD/JB3zgb2uz1mxIqc3aqmCkMHPbpsVrDSYbWRru
 ZxA2KoNCSVWDzJae8+zt1VmdNmX7BPCgxUWTlCVB8iYceKW8F5n41IFaCQk7OiF/d9sx5
 89hMwZodUq6VdyQBPOPKp2ab52iH0EY5MI841jPly1oAUx09Lox2fYzvBDd3zJrkxrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793203306;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=naOIatMRZmrDAx/x9523dVP3OThUFKzZDqOgk9kTf2k=;
 b=pZs7oVgcmrkwsphhHN0N1G/iBLy0ZPbUqa+Em3h14t0a6sXwYOqekXaYlbO052bjfprr
 FbXSxuwQdqkPQHAYdcABaYTOhzRrBXbuquj9/TXLXsMA4AA0I40LegZWx0yKizz8y36km
 cL9Hgb2F/m7gRf4Q4Eeg0N3SOUTlrULMKtx8/+Y3AXeJX5rigepgyUUlMcyqZIdTnJfLF
 Fun04+EnRMw85E/NqG+0XNpI/TaBWdBqsgJlHcFUV1MOHBoAt1v+R8Y6ku2Va4biibf5e
 7gQmML/945WNzC2EHd3ffNZh3rtUjxppSz+8SlhNNi9GFp+we3yoUOK8oBAdP+86wGw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=kvAYHq9i; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=kvAYHq9i
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B495040533
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:45 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so9681335e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793203303; x=1793808103;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=naOIatMRZmrDAx/x9523dVP3OThUFKzZDqOgk9kTf2k=;
 b=kvAYHq9iYRoATM/3vT/Z70RjqJ3Db0qhi5BmqknYiEp6E6H3tFK5NcnW30lB/1Jgd7
 u+6PReFnj9vDSbmJBg7haNnPDP8MNHVx0rNPRHunBfK4I6UT1YfU5dLJKPgQOjOQ9IU6
 5xP0aJ//PdIz3C7XL0BSYbH0SpTxO7GZRFREJyKX0vzBnS1AuGarvv54UFfToTNCUs7S
 LdB6dlFFfj8S8ctyjPIbhtM3MSaV+wFP4T6yWS9E76yiaQ2hFzopFL9i9C9MrH8Og+AN
 z7/RrHU4zYhFDK8q40329lFvE7ChTwO/FXIoJsn+WzdmsAeq354eBKUjAhkwENnVNsGI
 HcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793203303; x=1793808103;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=naOIatMRZmrDAx/x9523dVP3OThUFKzZDqOgk9kTf2k=;
 b=jZgpvzGEHwgmj+6j7Q1Gk3wrV6fKsYkQ2V3scJbWsT+cxvrVhE28fjSgWwCtiJ3BE9
 gF/jJQCG+62Z3ixgDGJ+G7H2rN03403fRaFwZCAAzGn4uwePVO0EdLsnj3rBeAk0os1V
 xZbvueTxDpZXTOqaygzPi1KpSUpCjGEz7D2sdEPdJNP750YmJN1dOegZfwkmvRDDoPYc
 KZY7qtubTs/gq556wOo/rv4wYIGu2usokgTrP+r7tipyhMWMNMwDBqHDgc9khSWqBHI5
 TmmTBGc6Qiu2DhLvl5JVgW8QoG8Q6mJJu0mGuo2TcsRWIn2WUC0JzPMsdPYsY3OkPEea
 772w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz41Aw2mRTD/ohS9L0KZj4zbJul8MQoxwzKe5/Ab03qAg1Y342Hq5wDST+XxuLjyN7oHkFA3GI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKV3jEHJeRZyEPdHzPXlX5VpcLAcq9M8SlL5tkpkASBmNY5O0pu
 fCY75aQ1UtSFpfTltQQEeSs3t/HvN7adrBzECSPEAeyaHcZhPHavht0Cj7RgcSV0ii8TadyhaVI
 BIChk9h4=
X-Gm-Gg: AYBFou0YnuIIHld6YAsgNBc6uPabUWdRdGPjjHCf55i0DtV0fFcjsnrqYUhqcf8ITEC
 +BkUxPhF1cnKvqokYiL1FbATexqx35m4xK2azKrLxrH0OvPX5lUL0Q//RsdjyAybQDYy2TftLYV
 MpAGrvFdAzuRUpM2Goc8UPTYGp+C8klCjntDbafr0d+EFzqsnnT5T/bjvaJib036IYG+1IS+k3j
 gVQORGdn8GGDYIxAVI8NjREYRgIYc8NjsxSm2i//OIY7ssrAZ2NZufZ3D3z/TdMYWre8CYJCO4h
 Ut9yxmH73GMLj3m4XhxZsLFc2Yh5VH6RHsNWb8IZkhplvOQWDihRM/c9Go1Sx5DtLljpkwI93ne
 LBicnOVMvmWNqvJcj9rBN9Dhu8vHyVvH+KTvboMBGd1r3fPNlbQwVTmCwnzPr14ROjnArX3QdVC
 0KdvCpJNYy4GFyPt4WpHq2wXXi0MtNM3/QCXIa7Th0kS7BEalp8zK+hgn6YYMIhRRbv5HBdF7IO
 MOmGU8/FZEHdcyOfbMLNl7VQy5GGqxZhND68DNbrg9CzIqtEPEgsObN5Vh5OjvZIOuJWkSHGcZX
 Scs+8G64VG7xSt4EEpg1eWry1Hpu1SkMr2VMS5zUVq5z14xywlhfd+UHCx6t9QzDXmonQJw=
X-Received: by 2002:a05:600c:198d:b0:4a2:1a:a11d with SMTP id
 5b1f17b1804b1-4a9610e1028mr62863605e9.0.1793203303181; 
 Wed, 28 Oct 2026 09:01:43 -0700 (PDT)
Received: from lion.localdomain (p5b29ef1e.dip0.t-ipconnect.de. [91.41.239.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80286fc6sm1686155e9.15.2026.10.28.09.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:01:41 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 u-boot@lists.u-boot-project.org, Han Gao <gaohan@iscas.ac.cn>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Han Gao <rabenda.cn@gmail.com>
In-Reply-To: <20260919-fixfetch-v1-1-f1e8b54d8a87@iscas.ac.cn>
References: <20260919-fixfetch-v1-1-f1e8b54d8a87@iscas.ac.cn>
Subject: Re: [PATCH] cmd: ufetch: avoid truncating storage sizes on 32-bit
 systems
Message-Id: <179320330137.1454330.11797553421342621479.b4-ty@b4>
Date: Wed, 28 Oct 2026 17:01:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Sat, 19 Sep 2026 04:35:33 +0800, Han Gao wrote:
> Storage capacities above 4 GiB are truncated when stored in size_t
> on 32-bit systems. Use a 64-bit accumulator and promote the block
> count before multiplication so 32-bit LBA configurations are also
> handled correctly.
> 
> Fixes: 86d462c05d57 ("cmd: add a fetch utility")
> 
> [...]

Applied, thanks!

[1/1] cmd: ufetch: avoid truncating storage sizes on 32-bit systems
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/7aa9fac8587a

Best regards,
-- 
// Casey (she/they)


