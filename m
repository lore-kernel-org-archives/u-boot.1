Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8408EDEBE5
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 18:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6234283F59;
	Tue,  3 Mar 2026 19:50:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZKgYtsXT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4022C83F64; Tue,  3 Mar 2026 19:50:57 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23D12838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 19:50:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-45effa36240so4686557b6e.1
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 10:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772563854; x=1773168654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ksSUdtmFMliKCWG4DV6cdQMFy9gRgLBTlQZKXhSPGFU=;
 b=ZKgYtsXThlqvTs+qE9d2ApZhtTTjwe4xr8KgLh79Ko4Rcxj3d+jl2UQVrlcJES/I5T
 sERoZk61UlM39FCYOyxMThoQxTZ7wKf2cECNPu/qXv4zxlX0aUbjtCqxA7ByEdBxac6L
 mNrOsj1vmXEyFItorEqhcCj01QZtW0lWzXDO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772563854; x=1773168654;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ksSUdtmFMliKCWG4DV6cdQMFy9gRgLBTlQZKXhSPGFU=;
 b=JItkr9iEYFjHpyMIccDFnfL3S8Cgh4jv1pAAYaWFPz6Xnvhi3LnpHrKVlOszfvob5l
 dYTVd202YJcuCSNNx6nwf2iFJWlWFgjiO6M1lQVuQ4vlcAKGzKFwytP94/43jFJm5qKP
 J+skx4LwIzihf6I6/9qRauq4kSvVXHYxv3jG9kxN3Igb737oj8Nfv2QN9dwe0Eblzx7C
 kC+4mPRtTkHAGPed8CBQ4xrpZtC7XV7xYgovPcJmuQ0cuX01y830a4cNw0UgXs9bt3JF
 R0lqILRRH7Vt4DVnAGYRbjxEkVp/ba6U4XbKedLuJSZUop8SV8Led9D4M8mPzrpjp3rK
 1bwg==
X-Gm-Message-State: AOJu0YyIsoovz+/jWn93s61EKA358YwnEzoctHZQtV1YdzWSfuYzq7af
 2AOSseXh9nPgn77BKPkP4F9ehJGsPo9xoveCI533jXJ+mJPwVl9PJcIQbrxYOOz3XEU=
X-Gm-Gg: ATEYQzzxlPd8j4ZFerjpkYrkrcR3ktjNRcg3qjh+vCjBD9Ykrhc9hRpGLn/NoRQaLJJ
 g/4oQUhEOVePDp5SPQ42NxNA3jYcFViCJUOFQ08p7pcBqkjfuutZczIKNoe7/ZlyPWKN8D/jHLO
 m3VgdKKEpyc7bGBu1RJOIBlZKoUDAN/fyo+rHFfn2JUB4riSB9DZSO4H1QjpA5PcubkObdlKX7z
 WNY05wYFF2T0nFU+07100PtmczvqGdwL5dMx8LOxh9VcIqDWhvvxEnhKSbUcFeS8nmbrtitoAeP
 ZsjP/T86HCrSnEHVtegn2uA3QqD5VcUFbbkAhifDD1Yo3Dai6/1CEark0XvU7Iz6P8VtTdAaNLd
 HhC8Ly8BS+0276ijfAjpK63jJaZUVQzjnVIrL8nYUc2lD7Zc6C58+yK6yOk23U2eh2MiEQ+pQJs
 JgIo2FgFEBT+T/qBRhlBRDkkch6dfxSGqizyxhxKoN8BqX+hUermlxpCLFIwcBWtBmsZuxX/mCp
 iEEPSxepAV7tTxXcAMhhyFEKj3F8EF30Lis0IQf6x5aHpxOzQ==
X-Received: by 2002:a05:6808:1396:b0:450:4628:e3ce with SMTP id
 5614622812f47-464be9ad719mr9779573b6e.15.1772563853833; 
 Tue, 03 Mar 2026 10:50:53 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb605f15sm10180475b6e.20.2026.03.03.10.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 10:50:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Romain Gantois <romain.gantois@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
In-Reply-To: <20260217-ofnode-to-fdt-null-v2-1-915e627d201b@bootlin.com>
References: <20260217-ofnode-to-fdt-null-v2-1-915e627d201b@bootlin.com>
Subject: Re: [PATCH v2] dm: core: Don't allow ofnode_to_fdt() to return
 NULL
Message-Id: <177256385287.3975993.17928342088487710709.b4-ty@konsulko.com>
Date: Tue, 03 Mar 2026 12:50:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 17 Feb 2026 10:27:52 +0100, Romain Gantois wrote:

> The ofnode_to_fdt() function may return a NULL pointer in multiple cases.
> Or, this function's return value is often passed directly to functions such
> as fdt_getprop() which end up dereferencing it, thus causing a NULL pointer
> exception.
> 
> Don't allow ofnode_to_fdt() to return NULL, to avoid a NULL pointer
> dereference.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] dm: core: Don't allow ofnode_to_fdt() to return NULL
      commit: 39e1ccc777563d8c769531f1dfce24d38d023086
-- 
Tom


