Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6DAC4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 14:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C2CA8822D;
	Thu, 11 Apr 2024 16:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UpXStpU2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 195448822A; Thu, 11 Apr 2024 16:19:49 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F5CE8822F
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 16:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-789f00aba19so482018285a.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712845185; x=1713449985; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZi6EZlMCSwTIOE5HWH3P6AYsvsBMzQX3hgCcaeA0MM=;
 b=UpXStpU2BPikWcpqPgo6q+p7v1tnWR2HiCdmKgpytBPo8XOnsqFZy8BFJddq+6tR9L
 u4QVjSn86h71rTaSd9hvvTTviC1hQdMole4l/81Ks/oBuCQZWgyVaelVcfy69Hae27O0
 T+S85KsjJTlkLSWOnxZgVyH+ySGlGJrB2pp8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712845185; x=1713449985;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZi6EZlMCSwTIOE5HWH3P6AYsvsBMzQX3hgCcaeA0MM=;
 b=MBAfNbMwt87tMMJhmr6VLRdAkfoCnj1WU+M5OIyUbrewHYy3kKCNATTAYo7QNj1kmA
 bZ3IolWHP+H8NwWNZiVXcl6TjCImA7n99Ur9USO/3Kvj2Vn/YbkGhb80Bd/YBgNBO0o4
 asXQtjXiwYYJT6dUmI+MwnyRcuEILnSui+Y+eBTNFkwBJhcRjpV7K6XRcyT2rW2aCKzn
 5M7pSdifSIu+jTFapQixsIp53DCZ2Ig1CBxY3ACYvm2wFK3YdCbg1q0e5gvHupg42Bix
 d72cNAkhYwgNC+R9/O6DbtlJlKyCCMcG4wJZnbjHyxR9xIGIFDBiz4ICTvwRXKCUBDQi
 dntw==
X-Gm-Message-State: AOJu0YxoW18wLqoMuY6aPnC7qw4VWHE2VAyzF+3cEEDEFRfifYQONyFB
 DBco7C6kOrQCUMLuKSOlN/bKz4Sk81gvthG2UEO4u3OX4kK6lqtrcUH9XDD++lQ=
X-Google-Smtp-Source: AGHT+IHFq58JEsmIe4Jon/zA4gkpGb3tgBbX6KB2yjTvy4LDW36276+zj+keg/EOkMMwT+1xV0paYw==
X-Received: by 2002:a05:6214:766:b0:699:274b:2173 with SMTP id
 f6-20020a056214076600b00699274b2173mr5127650qvz.14.1712845185434; 
 Thu, 11 Apr 2024 07:19:45 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 dd9-20020ad45809000000b0069941839737sm1002421qvb.3.2024.04.11.07.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 07:19:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Bin Meng <bmeng@tinylab.org>, Devarsh Thakkar <devarsht@ti.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Fabio Estevam <festevam@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Nikhil M Jain <n-jain1@ti.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 qemu-devel@nongnu.org
In-Reply-To: <20240104151042.695717-1-sjg@chromium.org>
References: <20240104151042.695717-1-sjg@chromium.org>
Subject: Re: [PATCH v6 0/7] Resolve issues with booting distros on x86
Message-Id: <171284518298.255737.6903946545215484016.b4-ty@konsulko.com>
Date: Thu, 11 Apr 2024 08:19:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Thu, 04 Jan 2024 08:10:35 -0700, Simon Glass wrote:

> This little series reprises the EFI-video fix, fixes a USB problem and
> enables a boot script for coreboot.
> 
> It also moves to truetype fonts for coreboot and qemu-x86, since the
> menus look much better and there are no strong size constraints.
> 
> With these changes it is possible to boot a Linux distro automatically
> with U-Boot on x86, including when U-Boot is the second-stage
> bootloader.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


