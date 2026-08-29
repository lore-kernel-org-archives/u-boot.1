Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF71EC61DD6
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 20:42:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 348166060E;
	Sat, 29 Aug 2026 20:42:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZjrtYwbmHaqO; Sat, 29 Aug 2026 20:42:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788036130;
	bh=A/LRQLDZXazRkB4JZELwMRMhi4lFhROppDJe/AMu7S0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TV1+FfsFgQHUbvMsIbGbnce2wIU2Fgm/wzx5U0k42Jn7AoGmKImfXBvvwwvxt/FwK
	 9JDGFkwOc/nX+7kcb3XTaAaWS9CNOAVT1fCPhkFkCPrQIJUfWM0qkIlrloOIQk7Buf
	 lgeof+G/O8BGiTTrNg9tT7FqlR/0jfxj+o3VvI5uk3dNi39Ek6cR6TPFvELG8xFQPP
	 QhymHX7oyTTVESKGqJN9RRkkyegr8Dq7RMSKQ279kJkr+YoYlxwpW5E10eTneeMQsH
	 ebchVaXBftuU3HBhxoK85FkegoumlNUqDmleANS7zq4X14arTRLVJPItLaoCQUlNgF
	 eGrGE2kJ8GeDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0949605EE;
	Sat, 29 Aug 2026 20:42:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 79636355
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 20:42:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6AA85406EC
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 20:42:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JJPE1WiBhfgc for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 20:42:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::4;
 helo=mail-oi2-x04.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=aUMmdaCR
Received: from mail-oi2-x04.google.com (mail-oi2-x04.google.com
 [IPv6:2607:f8b0:4864:32::4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E702406EA
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 20:42:04 +0000 (UTC)
Received: by mail-oi2-x04.google.com with SMTP id
 46e09a7af769-7f4e10aa28cso398511a34.0
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 13:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788036123; x=1788640923;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A/LRQLDZXazRkB4JZELwMRMhi4lFhROppDJe/AMu7S0=;
 b=aUMmdaCROH5dSsN+PBU1CEaTmfMywKyj4OggMWmHQTKjhVtvG3xp4CpNpJU6ZXIR9g
 oXg2hHDNMVTXxqdGHu9r6HUase3QnZbclVpvojexlcYMsgzSVjUZFoAL8jr5fuM1gV+2
 cYgVibX/LF73JsCshJfViQT6KY2V6Ac8sOplA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788036123; x=1788640923;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A/LRQLDZXazRkB4JZELwMRMhi4lFhROppDJe/AMu7S0=;
 b=rzLW0KAkKqUPsfrJXUs1FcH6fPOOR5sZmwfucq3+ic8eSTGI/pOQn1x8DQdJcXNGjW
 VF9suXgIttHEYoZaD/LQbnFpsKMZgLazlmxpzxesJ3/3uutDc0MeZWHWn40AUwip+UTp
 bV/ju+2iGgE5A+p569QDkIvaGqT/5ikEtP+Ygxp/BWoM96M35kduWt4nxUNPSK4t6N2j
 THITmm526U5SXsrygrjNMPDHVC0gY6Q0WobCWqEyAlHsEvMRGpcMQc/mn/4OjmJb8PzO
 RSWmDWLAFNkTshzMHpd8wKP4Y32VQQ8dciKIFs8Ay+BX1Uu/qu9Xblsp4q6bGs4ldesA
 t5nw==
X-Gm-Message-State: AFuF++lcNtApqAE2DhyPHlykd8/Txt5MPEB3VrtgTpJDeGWS6vqXv6H+
 d/g/sSMmmGfdwJJP18i53uJqZfqL0jOxeqPMrrJUWQcpFV2QY2yiU1JQ7thhV0U/0NrvSbp13aX
 MfN69/jeySK/2m/U=
X-Gm-Gg: AR+sD12Rf1O1w63RKaeax5xm5yoU1qCdDTYi2X+af4tOo8yvZU6/335a4P9yRqwRs26
 1+4TguwogiJ7JaGp9MvVDIKQbM8DE7t5bSjYN+ry/1iAvhmJ8u4M3588F5GPov2kRBn80zp+nop
 bGNzdgiR3iEI6J+iWJq71SyT+F4/PwGJU5CAvMvcEfHL4yDexDWrFlScDUgu79dcHH1Ry5RDihq
 rUkKzhIjmgzbdJh15bPs/EHR8V7BCOgLVKk1plppoeEE7DNr11XOGdjFENsOMMKI/F6GQaMm2XU
 q6MuXSKVUkVBGzUCwUDDZi25r2+lY1VoqoicLHlRa6RrlFBnJr9bIc1CY+NY81k4crcf2P0UnlY
 +GkGp+IOFhhhJZRU6xaJLEyNO6Ewhh3joRz364GuPcOotuEtQmelj6fqCgJy77qEbhLu4Z0NoZk
 2YfzXlMThRJykWs6/bPMmVAR6eURjrG7d3lmNHDheYrH+KqDgfp09nibKga4+mPEHWuJuEeOdO5
 TlYT1RUKClzGpvn33McDE9dBzwWuKT6E0t5dlCGKEnvTlRa87DjKn+kx8dV0QFiSHWWHxlki2an
 8pT1PsAO
X-Received: by 2002:a05:6830:67d8:b0:7dc:4947:36a1 with SMTP id
 46e09a7af769-7f4f25db258mr19494880a34.12.1788036123184; 
 Sat, 29 Aug 2026 13:42:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4fa6bc42fsm4165532a34.6.2026.08.29.13.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 13:42:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260829121154.831957-1-u-boot@0leil.net>
References: <20260829121154.831957-1-u-boot@0leil.net>
Subject: Re: [GIT PULL] Please pull u-boot-rockchip-2027.01-20260828 into next
Message-Id: <178803612247.686790.133306899144078447.b4-ty@konsulko.com>
Date: Sat, 29 Aug 2026 14:42:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Sat, 29 Aug 2026 14:11:05 +0200, Quentin Schulz wrote:

> CI for this pull request is available here: https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/pipelines/1115
> 
> The following changes since commit 41541f47a3af93d76d63c2d6d1f1c859fa3dd61a:
> 
>   global_data: Only include driver model fields when DM is enabled (2026-08-17 18:46:29 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


