Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEABC5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 17:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5579D87FC9;
	Tue, 20 Feb 2024 18:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ivyxUnx2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B46D87F9A; Tue, 20 Feb 2024 18:56:37 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EECE87FE5
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 18:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5645960cd56so3649613a12.1
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 09:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708451777; x=1709056577; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6ZiGg+W7so85/LaK4dVdN02FjTPm3mlJI1RzXeRfMpo=;
 b=ivyxUnx2WaxDM/Jn8ZLO8TuBe4eL6ngU/On/b0iI/PnsmenYankVFW318RuaqbRdcF
 hcViU+bLrGqtGpSnLuDUWhTdu7ovVzPfukuhKN9E82PzFd6Yju5NVmmDuWjZt+L3WsYD
 56X9iqmzw5axESCxQwCbijNC9IbO935Eq4NAcDmsBxCpIPzVBQWbtj0/leHx1viTkUhN
 R4xV1rT+UWUt4rlmupNsgLlQY8gQ/JuAphatByFgJDbsiV0AJXSweRYzOKAw1/CZpVEX
 FN2cu2EjsKSXP08RYkm6xQ00AB64ou7l3Z6BPIgW4lV6VpDDg43/dR7GYQ6wJIztT4o3
 hGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708451777; x=1709056577;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6ZiGg+W7so85/LaK4dVdN02FjTPm3mlJI1RzXeRfMpo=;
 b=DHs68IaUVSxcGutU3zdQyfyF5A7zP18CsTVbF8CJSMsOUDN0ELhzopUKiaDQnULEiI
 BAyjWRaGZs9UScd2YukG76CaECa8dqNxH6k/AsnJ0GZrHdE470orARaBhxG1wlENKEcu
 I66uOsJTjZuZc5EwEP4675XMNOwCI9D+2pA1lmNrhbr/ucIVq/NbQHbCKdQuIlCoe9V+
 HxLGC9qBpz5vThL+T9gzD+K+ekJyKNiBEZi+JJpO2CbBfCG4NoLo4Pir1vCjY4GRa2oF
 0J6KOaJ/XxRBKQKsay2g6ILivujxMIGJ38tn+tEzhQzFk3NE4loDRh4FF+7taz3tZpA0
 OFIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWt632jM/HYVw7XKeHkdlVy17NQpSInfQoyAMWldw8mqM7Y9NhYl2uTRLm2TJ73aqMc3NKl7BJ2ha/vijLMLLHLDme4A==
X-Gm-Message-State: AOJu0Ywb5zFCzeilKzwqLLMcxljzCF2+MPcwTWkSkfcMiYBYU/JVQfb7
 KDox6ROn78MSq3+a90HJhxku/iIFNKdEQjvCRaBJUkngF1XsAtb5459U7HKRi8w=
X-Google-Smtp-Source: AGHT+IF27OZTa8SJIFEfhfVk9Nirq/s4oSlisSfUVYLZp1M3RIHfGLY/XSUyGE01/aCLHaoMOMKZww==
X-Received: by 2002:aa7:d508:0:b0:564:5407:ce22 with SMTP id
 y8-20020aa7d508000000b005645407ce22mr4820289edq.21.1708451776896; 
 Tue, 20 Feb 2024 09:56:16 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 e18-20020a056402149200b00563c63e0a13sm3864199edv.49.2024.02.20.09.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 09:56:16 -0800 (PST)
Date: Tue, 20 Feb 2024 20:56:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "niek.nooijens@omron.com" <niek.nooijens@omron.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] implement policy_pcr commands to lock NV-indexes behind
 a PCR
Message-ID: <fe03964f-3401-4dcb-91bc-453d2ba33e63@moroto.mountain>
References: <OS3P286MB14956B3F726B34ECC742119CF6502@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3P286MB14956B3F726B34ECC742119CF6502@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

I'm kind of new to u-boot and I'm not really able to review this code
as well as I should.

But also I can't apply the patch.  It seems white space damaged?  The
kernel has a good document on how to do this.  I'm pretty sure u-boot
does as well but I'm new.
https://www.kernel.org/doc/Documentation/process/email-clients.rst

Please run your patch through the scripts/checkpatch.pl script.  Stuff
like this triggers a warning:

> +static int do_tpm_nv_write_value(struct cmd_tbl *cmdtp, int flag,
> +                        int argc, char *const argv[]) //TODO: session handle from auth session!
> +{
> +     struct udevice *dev;
> +     u32 nv_addr, nv_size, rc;
> +     void *session_addr = NULL;
> +     int ret;
> +
> +     ret = get_tpm(&dev);
> +           if (ret)
> +                 return ret;
> +
> +           if (argc < 4)
> +                 return CMD_RET_USAGE;


WARNING: suspect code indent for conditional statements (0, 0)
#250: FILE: cmd/tpm-v2.c:437:
+     if (ret)
+           return ret;

WARNING: suspect code indent for conditional statements (0, 0)
#253: FILE: cmd/tpm-v2.c:440:
+     if (argc < 4)
+           return CMD_RET_USAGE;

Also the subject should have a subsystem prefix and the information from
the email should be moved into the commit message.  Currently the commit
message is empty.

> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> index 33dd103767..5b60883777 100644
> --- a/include/tpm-v2.h
> +++ b/include/tpm-v2.h
> @@ -301,7 +301,8 @@ enum tpm2_startup_types {
>   */
>  enum tpm2_handles {
>       TPM2_RH_OWNER           = 0x40000001,
> -     TPM2_RS_PW        = 0x40000009,
> +     TPM2_RH_NULL            = 0x40000007,
> +     TPM2_RS_PW              = 0x40000009,

Changing TPM2_RS_PW is an unrelated whitespace change.  Do that as a
separate patch.  But I don't get it at all because the TPM2_RS_PW enum
has always been indented correctly as far as I can see.  So it's a
puzzle.

I mean there are a lot of TODOs and I understand that you just wanted a
high level review but I kept getting distracted and lost and I couldn't
apply the patch so it was just really hard to figure out what was going
on.  :(

regards,
dan carpenter

