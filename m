Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0531CA9EBD
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 18:14:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0A114093F;
	Fri,  9 Oct 2026 18:14:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a7XcRxsQR5Yp; Fri,  9 Oct 2026 18:14:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2CE08408BC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791569681;
	b=Tnx0DGmhARC4+O+dkmOEPfE2u3pfiRQWEyrpFizqoKpEkMt9x1yRs7gOeyCHuh5rGXy6
	 Kvqe9tUwQJtPF/Cuplz0ZNu5ROOI//DabA54zuh7SQhH6n7FfAsmzbtnmzGNBeMZgjOkx
	 G/TYe9kmJhbg5cZZ9giXvET1Wuftw7OvCE/pBlclJVmX2AIBytTvJGzCe+C2K6yEOzBT/
	 RCXwX9AXuNlJbRnFHA5TNw2pKA7gD10XKLefYDgmo7UXzSOhAMlWWZZrHmpaOFskT7A2s
	 BBJ/LLcQwTMjBNGHbZL7ObrmZ6SDYocEl1zfrM2QntrKY4K4OJwRQIYHetFSgzzCbXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791569681;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MY2lx9w4r8Y9Y3EVJDNhS3VK1a0bZ9WFY91oMjTC+HI=;
	b=hKO20LbEyVZxviVyB/MCXiIuL6fgXGS1CKOqgXll7nDCsYFD9e2wPFYCN2TiRuYWv2J9
	 wWAt902tPMQ2XTuAo56Rlx0fsKBneWQ6oqC8x8dN0l22t+CIeYxlJa6tk1wfgCTGWfPe/
	 wfXzRf5nyo8OKf57ZMm6YJViXcc+znBVXVgEShrdRuM8JcOGH9CKwT7ChIgU2jqEMETI9
	 UVVFVNXBLEXWjhu1VM2C8wGH+ntHtny0Pjz3ik2hTP/gdI8Ua3L9AOgkMoAqqV13uUtrJ
	 aJJsUwiyxCbTEWv806bDTpVrE9ejcAqI2tc0FPYBk+wYw82elGgy+VlPCIh9bfDtgFQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DRnaZ+tf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791569681;
	bh=MY2lx9w4r8Y9Y3EVJDNhS3VK1a0bZ9WFY91oMjTC+HI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yiuI6po8G5vQcCUzMkG30ZNAtoMcADuLDJtWrUFER/JN5s9cKR8X6/C5A/ggxzaGn
	 +VdlMOp8Am2ubUhb0A8IxbX5KLkCiGs+tHmY+DvdGfkCuvaG7Mv31cTaP2XfdJ3Wf6
	 4MBcU/zaLP8MkFWUjuPBzwQZAqsPzdWQcOHtndPXJO8xPYzcp0FOzCXZwq3aWEW8CA
	 +nU90lxcI7TlWHC3rqXZvY769gMV+wauDp5r2NbhofDYNE5DITNSJLd2p7qNPYWdY6
	 eWtSqfB/d/5wTABISwpEFjpQSE3PvghQfJC/002R7HKw8cAsUqf/pCm5n2786nK+Dy
	 JkkT/IY+rxLBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2CE08408BC;
	Fri,  9 Oct 2026 18:14:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D377317
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:26:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5AA37408C6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:26:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sp9ukXJF6HzS for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:26:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A18F440863
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791566808;
 b=XGDztkWLYu4+mftYchqk16myu8NmRlJY2cb7jJ122sYFjfSxKXXlhbj8/4q0pYs1V3kk
 hxOscmpKRcBErdT+5eRE3HVW/1tfEeqnwiVe37ZiuygHwiaRZ42dMLZzzV4ojbn+aYXS+
 lIo42Mvdx8mrLU6kt+/kVkzQ9P2DivI7FOFNhP+CuxOvALETvuk23MrI5f543ll2AM5kH
 74bx8wi6xEgV3xasQwCvGb6pBxtK3C8hN4q2BxlWXHjXD6HpIgH7AJGSVfIq1d3dph3z5
 rWF1uh4PfOSBbB79D4rYXxHFtbvaCzT2/YOh+MJIhQnCsQS5/x4HoDPn+9MyAVaaZjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791566808;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=MY2lx9w4r8Y9Y3EVJDNhS3VK1a0bZ9WFY91oMjTC+HI=;
 b=XFdqvGbq6xgb0kfbNogbdSEAIWssWKhiJsX06bbtiWfL/MgCr96/IHDsK/5msubNtVcw
 +EpHzqn9x+O1VxHChFKdc77YacYrIMbo5rPFVRNLy9yqK5LqNwwjoiTOIDC4h3Hh2mRUq
 YlqdxTi1ebcwFlJt7ARyqb2itmBn5NA7zq4azn6MMqGVIHeLcskdGGvOAFzv1a0FUhT/5
 hWYi1EOikRLJ5NfyzFj6ZjNLnw3ilvWbttVeqt3VSHRHyL3N0uEksv/G55NRm83AFKZQE
 mm21W/yCmss+58XUzK/AvwbcMy1cNmyFjzl8/fQDeBljbLN9hBmQ3AVLPPjPeXB7lAA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DRnaZ+tf; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=vinicius.eduardo.pedrosa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DRnaZ+tf
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A18F440863
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:26:48 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6dd7070699eso67922eaf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 10:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791566807; x=1792171607;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MY2lx9w4r8Y9Y3EVJDNhS3VK1a0bZ9WFY91oMjTC+HI=;
 b=DRnaZ+tfWBJOhuLSIpbFyn2XO18V0W4HPCuPbPOlo7E9fwbcw9eubZAzg5qejw4XlN
 UJxT+fy6JIeTe6fBLYW8o0vIqM12n10B9twAmJYGYdpvq2t3+7qULKN3lXmtUp0avdvs
 jKCrhiHsEaSxGo5fKUmQP9Lpx2OHMikIbYymrisjmPg+owh4RyeIf/g5xwIjIApC+jfz
 EexWWqyxD0Zn9B/JGRsqR5CuM6UJ9ZY00kkBdHkpnUTu/gZa/UldGVSnjZoE0uPqA2ve
 08bGz33BkTkBWi0MSuMSD1ErDzImiC+6a79vLCALHslIHP1HJkggM7aPplcIfTgT1+ov
 bcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791566807; x=1792171607;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MY2lx9w4r8Y9Y3EVJDNhS3VK1a0bZ9WFY91oMjTC+HI=;
 b=HPCruy4NTb4ctwRqMOOBJLARR4BWMyUv1lRQwPR+bkKMqd28RIPtqNIeMgASVfQpCA
 64tOMdBWu3cCSNH9mXazfraBDYEMyvIaB9XKjerfjXGm7vJKyfvj3osKHrSWOKRPCseD
 JoML21BuaS07zaZviQCgvR9eqnRFog8n4TceiDvDiZXwhTZRnr8V9xRty71JnlUyOvwe
 jaqBMdRJjQRwONuTsPqhWh+3qJOwOYU3DDs79DCWrkFN1d4B0qbRndDIo9/wgXeMBcdJ
 bplcBIf+BVOp4o7Cv6q5wYGRYQcaEYSCJmfrBe0wnu+mkei9vFkQ/e00DekILdE2cIDt
 GvlA==
X-Gm-Message-State: AFuF++nmUwqanPM9Iyhz33fSpcHT/I6/cuFZTl6keyAXIXFJRL/qosUL
 jkAWuv3f2CcaSj902U9hcIzZtqB9yaXAZfPTp4Fy/fHm3D5kD4tocl0x
X-Gm-Gg: AYBFou37MMyEFEjGlLco8gAo1aKa/poF+G5zlD8PXSO58h8akeD+ynzucFMf6FIAhAL
 bhCz7hUx5eUiK3s69w/R2OYGmjN1MsRkCw99L4G7mX0BxbJuzQDrpv8SkiAlc4BiqaXHzDbkxkm
 JqEnDbkTbtIijlh7pTbdQngAJ0VFl/8uDlx1Rql700ZP3LVhQKGqmIWRYJHPd/2M6lIQ+xX3rV5
 1o0qXGsT/Vco8tjct+lJ6wxCTpZdHn5iJy+BTK+PvH/SCz3fprRsAihtrT9/00WUyyybA7H7Gng
 dotysA0ZJKHMwe7LvHNCvrbRccI3jujb+4iPEELS1eya+VGg+QtlI+QmkV22EM1EPBqKMnX4yeq
 8ouCXtfrV3iwhWNt1AbcD5E1fgdqF9j/L1eiphT93qsmtPGpA06tysmrgvuU04TMwVsdc6ii/ew
 fctah/q7DJFVTpgUhw9oQzaMbDrYNVG9gkCUloLVYBOotV7ry0H6vL/EVvpSePYq55y5Zo9D0bt
 fg4moxvOoxqTR8hKNrgE+EZ1Kvlk9rQiNsbXpHGb3sId/lF71rofedz1wbTheh3yMI0cgfKe42t
 Ne37ykEdEGte2ZdaSg==
X-Received: by 2002:a05:6820:4c11:b0:6d7:a325:35f7 with SMTP id
 006d021491bc7-6ef129ede6fmr1932680eaf.81.1791566807345; 
 Fri, 09 Oct 2026 10:26:47 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.237.181])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a850b675sm2499746fac.9.2026.10.09.10.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 10:26:46 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
	Yixun Lan <dlan@gentoo.org>
Cc: u-boot@lists.u-boot-project.org, linux-sunxi@lists.linux.dev,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v3 0/9] sunxi: Add support for A733 SoC
Date: Fri,  9 Oct 2026 14:26:32 -0300
Message-ID: <20261009172633.357866-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <46b973a1-3c3c-4321-80fa-a929375d52bf@arm.com>
References: <20260113-01-a733-soc-support-v3-0-f19dcd098f60@gentoo.org>
 <20261009161409.256732-1-vinicius.eduardo.pedrosa@gmail.com>
 <46b973a1-3c3c-4321-80fa-a929375d52bf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 18:14:35 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Andre,

On 10/9/26 18:29, Andre Przywara wrote:
> BUT: it might just work, and then it's good enough for that time where
> we rely on boot0 for DRAM init.

It does. Without the SPL header, get_ram_size() found 1 GiB here, and
a PSCI reset through BL31 still worked afterwards. The probe seems to
detect DRAM aliasing at the 1 GiB boundary on this board.

Thanks,
Vinicius
