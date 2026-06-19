Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10513CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 12:16:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A8E3849ED;
	Fri, 19 Jun 2026 14:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MbW50LBp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19041849EE; Fri, 19 Jun 2026 14:16:04 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E507E849E4
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 14:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-695737cf38bso2911039a12.0
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 05:16:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781871361; cv=none;
 d=google.com; s=arc-20240605;
 b=X0t/6748iDSHEmUTfH65LuV/rfb9lNBXENdqHcqivNw1LBd100XM1VrublFgpqcgCD
 cCw8t7Tmm67bfhaTqXumHTCgz6iqFZZ8r/rF8PKLNQP1B+JKMDcjXK91xd5ZI2ANkP4I
 bMBEi8NjTgeRhNAZl1+cSejG/rOPf3vtxlQ5/HV5LI7qq4vjzzCJAYb9VhFzvwb+LVPH
 UvuNMDuevIjkDoOMfZFovSUgpf8fqMNsQAfQYXyeArqeBRgUBdz0b/qwFuHhSL+yrB2N
 YXeZJHndFVc+5RIGJ69YFMi5525rTMfDfQCYCnFtpRIbHKvH0uPB1YcWx3eG1zHOd6yl
 K01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MmeTkNdz5tZU3Vf9/3JJlULtplNxtLMNfwDycBRLMa0=;
 fh=LNzFrO3x4ja7y8VIEf3TUbrT4J7d+qKtvjb5Ne2aQZE=;
 b=Z+038NV/IKgrGern2W+yOli8DQS+9ewE3jU+J/ybVC1JCyNdFDZVB5cJ7/Ju1IFy5Q
 o5VsIyxBbU2QaaEFVj2GP+9plQjrS+YS9xdaDSvw8O4VxiUxrC6CIPztcPoceH7+ebDj
 rqzSfsR/UEIRFqIZYPjYAKPWRqB5DG7JI8Y63qObm17j3xHwJd5XHWqizjcWDCom5j0s
 ovckDOReFZflDAjv/TWaOMpG++DoOasF/4kxzKoTrwHivLFxW9zuurKUQmAcskLb1dI8
 6bGgFJS0iMc8IZSlI4c4ejkyHq5kJbjlJKoJ9YGx/+av5cpWCIWokTZaRpvtXgdwHbEI
 G9Ug==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781871361; x=1782476161; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MmeTkNdz5tZU3Vf9/3JJlULtplNxtLMNfwDycBRLMa0=;
 b=MbW50LBpqTL644trbXENlcBH9qE8SGjBR7TQkZy2lPcDhZfFEXD7hEWKjbJmMzRH+K
 teqP6SsLzYeN4P/fjIVOxhOlt8NagGLHS5HMVt44cbNyux5Akpha/LISpAhh3tQtIbfM
 48I/irG+xLMhhM5CprwFazSvqbpInWwe4CiO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781871361; x=1782476161;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MmeTkNdz5tZU3Vf9/3JJlULtplNxtLMNfwDycBRLMa0=;
 b=XgKPfCAT4rmUARtHq1kH1f3AtGvj1cR2k4Q95pXF3XmNZsrTGahJjLrHp7SoeEi4kx
 ae9B0p3ybo4ART7sBkLWX0IJu6QQcizyYEgrFWOxbTxwzEPHyumWT8CdBGCH0lyZvXhp
 x9m5iia/2NV2YvuF3FaxtLtb3sNqjtB2+TgqKviMB+kNYSD+0bwmCSQ5aFVy/OmbCbrf
 ulO95avfKMUZzHIFtuj17K0FlDQh8vg3utI41k7RQIAHQYGUxVt7dppS+fID8kXAa5Ib
 HHDxKiy74iAaE6sT79tDe8Y8pRCOzvY5tHcfEuu258vh2STYfhYoxhPiGTgURtbQONmd
 Nm0w==
X-Gm-Message-State: AOJu0Ywg0qeRysSZwGkZbzbrTV3PC6KsSmEy8KMwensG8GToFd90Kv/4
 l6mROy47QJrJ90JOjZj20YnKnArqdheFLl48Z594tSByQ7s/OEUKA1u/5/UkJfTXpRS0kVPHF4D
 K9H+5IrH+Fg7QAceXB8VYfbY/pQu3W/eCHcjTd5dnRKELHxSfZzg1SA==
X-Gm-Gg: AfdE7ckZA6U925w9Rr6UeVlHmrnCGO6gJGsIisMe2oxT4+i3jo1w+7VBlZ6wj+dH0FE
 KyIQeXCRt+63dQTLCsWTO3t/gtZdCgLJaRQEImtUeslrOLPqxtv2dyI4HUDEJWiFeN/Zy2AVHdE
 GEWcM11qpL+FgMQr+LH+2jH6ucpN1+063KUFBkwJpjc1r4+vtkaKtCkE4T58NBo9fu0maAofKL/
 qBV3rVX5z6M7CsNQH789iPbkkC8JOnU1waU3cxDTf5sxpndhHGB2bTTAqMevYLHMa3oPwDfRQ==
X-Received: by 2002:a05:6402:5256:b0:683:1cc8:84ae with SMTP id
 4fb4d7f45d1cf-696ee437a29mr1662003a12.7.1781871361302; Fri, 19 Jun 2026
 05:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 19 Jun 2026 13:15:49 +0100
X-Gm-Features: AVVi8Cd1g183GVl3Yecr-1KZMADtH33MZZwtbjdtAs_UbmQlaOQw5GO6m87OkEA
Message-ID: <CAFLszTi2atMKBen5inTP+XUTJNZEYGGdz136da8HFUxoX4dW-A@mail.gmail.com>
Subject: Re: [v5,00/13] Qualcomm IPQ5210 SoC bringup
To: varadarajan.narayanan@oss.qualcomm.com
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Varadarajan,

On 2026-06-17T10:17:59, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:

> mach-snapdragon: Add commands to create wrapper ELF

Patches 1 and 2 introduce binman etypes (qcom-config, qcom-lib,
qcom-appsbl) to build the next-stage FIT, but patch 11 then drops back
to a custom Makefile.xpl + linker-script mechanism to wrap the SPL in
an ELF for the boot ROM. Two image-creation mechanisms for the same
SoC is what binman exists to avoid. Please can you see whether the
wrap-elf step can be expressed as a binman entry (an objcopy/ld
wrapping etype, or extending the existing qcom-* etypes) so the whole
flow lives in the binman dts?

> Working features ... Serial console, UART, MMC

Serial console and UART are the same thing here.

Regards,
Simon
