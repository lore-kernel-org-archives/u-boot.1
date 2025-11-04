Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3921CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 21:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 484B58394E;
	Tue,  4 Nov 2025 22:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j7p8/yQC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ADA283952; Tue,  4 Nov 2025 22:55:48 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47D4683936
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 22:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-651cda151f0so3106007eaf.3
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 13:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762293345; x=1762898145; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9avWUAj2SdVR2zzgRZ1ADGAY7Va0No/+hWRRsxrM6Tk=;
 b=j7p8/yQCn8fwNxSmfCJSWUqv4FZtes9KMq1YyO/Xf8u7TVcgtixhSTk+2scIXcQrND
 sYPY1icYskhPqXebc9c2yj4ahWLWt67KXUnNw1aDlT9SEubeIoNSuLd3UNH/NLPhZNjg
 hcA54lKiPLhlFyp8TMVZUbVe65UosOlPMptYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762293345; x=1762898145;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9avWUAj2SdVR2zzgRZ1ADGAY7Va0No/+hWRRsxrM6Tk=;
 b=fYKkKUquc6o4lzJylgGnOAEgKgnV4YsRjHv8sXHwGoUEuic/8/h0FwZJOal80c/vpv
 X6hq2DkrmJ55Y2aPY/CvuOFCxSJnJ25/P6ROjmZI5QtV8cUV8ZaPSjRs6lSS2nVvxmTg
 MKXlS/Ecohf4GQTI5nCykW8E2k8KkyZ0aDxygU1WjNnXRq+jg4E7O3etUoQNliOoCHyG
 IND2hCYy7qYkJgR3oL4vwaj7gfiGvo+/lVgh4FjALO2wotM9OHnLW5IyFAHjeIK/286k
 LgqjhaB2CFQN5Dvjckjt9Eh+ah7nZQV/8qKnwnRjvhvFOBNTBozP051/s8yNg7K9blUn
 RncQ==
X-Gm-Message-State: AOJu0YzBxiconNuX2AGgux7nao9yvDkj63KFJ3YFz2MDdDytzqwYUxdT
 AK03w9Y5I9tvkfeG1XncVr/2nL0+H+iQ0X90Bdyluyik/LhKPwPekCdNhrCc+8A/7+wuY+bga5c
 gtwXRAsoX9w==
X-Gm-Gg: ASbGncuv3rw+ON5VJT4aCyKa7z0eLy2CpqtsYmO3fgfECw5GIwji0CTqYc/rWtyYAfK
 ippwGWlPp9XKb088tW35FmuZbvjOkO7y+bcyOThIzWR/ys1NCFxLxDXOujDjAo0F7YoCQZ4FD5d
 G6kwe9/h3z2Hk8YAQuCvC5G1ODZC5IqbFw8a7EIee8aG18NJkmeH97ujUzCkpCp9b+N+87+YFAk
 AriG65NddGMmWXBJevVihBL6eOeN6BrqnL+PG8VJwMb1W8+GMFY9R3fBRO6wq/hG+HIPqdT/60M
 RG1pXImRdXjtf4kx7pgDBwlwQvijvwcVcrdH7dePmbxZzwVnR6HmVMN2mGyy5tfQA6jephWyikj
 J/I9mGN5HBt//VkLarxwBhlmyRUbscKwzmOqbX7Mbw9gAlTqDdYa9VIdX0D0ETY/y34IVcvCgm1
 ZNAOX60Ip2Y8hng8LBPMx/X2NBvmR1ALiCkMi3Iw==
X-Google-Smtp-Source: AGHT+IHOm5jiKhTdl3ZzhZayWt0E/IaM/E5lNyJ1iy/huRQOOoPDOMclSqKOuQPqMGfrfxLGegJ1EA==
X-Received: by 2002:a05:6870:1685:b0:3d2:4f4a:9212 with SMTP id
 586e51a60fabf-3e1992694efmr502308fac.3.1762293345021; 
 Tue, 04 Nov 2025 13:55:45 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3dff736d560sm1448134fac.18.2025.11.04.13.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 13:55:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251104180044.1507580-1-festevam@gmail.com>
References: <20251104180044.1507580-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20251104
Message-Id: <176229334433.2371545.13618792419605757647.b4-ty@konsulko.com>
Date: Tue, 04 Nov 2025 15:55:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 04 Nov 2025 15:00:44 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit c9fdb9ac4d5234953ffaaef0cfc9d4ccb03f0ce5:
> 
>   Merge patch series "Allow falcon boot from A-core SPL on K3 devices" (2025-11-03 13:18:26 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


