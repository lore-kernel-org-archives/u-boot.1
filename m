Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD8DC5DF86
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 18:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B50BF80B83;
	Thu, 20 Aug 2026 18:55:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UIEFJf0jjml3; Thu, 20 Aug 2026 18:55:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787252151;
	bh=VLGQgAdnNWqySHrWdVS03WNWuDVki+LY139R3Kj87Pk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YimhORG+Z3N31Lt6c5YnsePu8H9Cep9Q6YThsPtXUnwZSukX56TO1wOm903DNjGmP
	 iarhq8wthJ12dZ0RA2h+uxyNgILYz7R6s8+inhyGTYBrlHDeTohMllcq+zeWUFQbZ8
	 DhRqjW/TSRBHwz6WSflCAh0UOVYeW2LFi5kJ+9QquUHowJg3eziMF50ARi/cnGvP+N
	 rr2LQOvZkA35FvvW5L2P59AJkfsGS1OcC2hZeHw7PoaJWV1N+WXD+wEXxVZavkO0nb
	 Jtze5qa2Pbxo07TqTfFYzK6WY+NsgEL4PVM42whJShymjaICl4RdOp+t/NYQkH1I5k
	 h2XbSzWvQim6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01B8080B84;
	Thu, 20 Aug 2026 18:55:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F47D4B8
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3B3CC40592
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:55:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wka4s_BdZ2s6 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 18:55:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=raAdKmzw
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2BE9E4058F
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:55:47 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6b1497f0453so207875eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787252146; x=1787856946;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VLGQgAdnNWqySHrWdVS03WNWuDVki+LY139R3Kj87Pk=;
 b=raAdKmzw8nj8+BUcktUKirE7h45wEWuTSGKuXRp0DuQ824G0jhc3Og4S6GX9FSqASN
 cuECHCk4wUSI3QugNePNrXsovKoRUtBYxWWzw9grq3IGxsEj4TWUNpfYFWrVqbXkansI
 7xlkboet1S3RGdt74B6OT7hdKmWT6ae9J4508=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787252146; x=1787856946;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VLGQgAdnNWqySHrWdVS03WNWuDVki+LY139R3Kj87Pk=;
 b=WovmEyXbfEMo9EPZLKPu3TMrpLnDQznIUYyeO/sz/0Z60CHJwwEqFp+OGYWr3AyQqW
 t5tU+V/6Jq4DluXXPf2NX6p7o6qSmgfHf2IFyTWES+Hb4RymAkRAoCGZ/Hk7UQiCU5Ed
 sxw1zR3dVEH2IryGpJoE13wISeNt4n99w3jR6Q65k1jWEZZU42yIcVL6bs5KqxDOR64D
 dtMpbL9pfryX4IN8JKk20hxw+E0nB1WZHpg4G73QvsH6tkkFPGwL8KD8lODfmohvac69
 lixsHcVDe8bjEHEg58sxFz1unM1KY+2pqT0f5FnBqRXBsmUUAhH9mNIzt7FCjvcpkrsL
 OQNA==
X-Gm-Message-State: AOJu0YwOPn+SEOJKb5zyVTJuBKHqKiMq4Fcney/HHzs3UdQSvADoFfge
 pmp4YeraTzR8pdymWoW6jBcibz21ohuKYZ6iUtWseogs/ihS5aRYY0FghNO06FrNg0A=
X-Gm-Gg: AR+sD11Xr8sog8v7F+Rz8RdzbecwISxVJxMx0tF9AiuJk+dTOz+CrZ8TWcF+wVJmHyX
 J8/WhC2Azh1BuAXz3GzoRugs3ptZjeYqYUuSgLv3x7ZsEHKOHJZrgDI3X2HjtLjtudQZ02J9Y9n
 /aIXLor8XJPhUOwgGWyTnk8bcxcB7H3HWjPaBvP2fclZUkaNNdEKS5y7w2DR/im/ph/uNYUXqfh
 jUvCQOQDTMm7P3bIV79w1tgq9PeqLKQ+xNI6+9r37460APV2szK7SUtoCM8Zk7sM3Axqttbb4op
 6yTRlhpKxSWLcWED+Eb1qQ9zAiXd2b5vzPkT4YpP+iCbaIB4ifSOku5uGWfD2A5NQ6o3Z7eY4lF
 er2k8yE2DfAKXAq+YU4jFD1ekfEexTVErhWBF3Ku9HnWJ82r4JWBP8iypUPnf3Z9gH27A6bYl5L
 i8V8IFKvU5FvXQQdBLkXMT8A2YivccV1VEfwaBPq6tYHywwe839sj8Gl2ov5ZcYerV/+7rzLK1P
 YytYsl/JUGEd38Qu6dVi5Dts/Itl+AeisjD4I6miK+Dx8kCpthCzLs+Z0DnA+p63/3/hpOTsbCS
 2Qs+iT2u
X-Received: by 2002:a05:6820:83cc:10b0:6b0:fd2d:d338 with SMTP id
 006d021491bc7-6b15949ae20mr666446eaf.36.1787252146119; 
 Thu, 20 Aug 2026 11:55:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13cb55782sm5729175eaf.1.2026.08.20.11.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 11:55:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Caleb Ethridge <Caleb.Ethridge@analog.com>
Cc: malysagreg@gmail.com, linux@analog.com, philip@philipmolloy.com, 
 Caleb Ethridge <caleb.ethridge@analog.com>
In-Reply-To: <cover.1786363875.git.caleb.ethridge@analog.com>
References: <cover.1786363875.git.caleb.ethridge@analog.com>
Subject: Re: [RESEND PATCH 0/2] sc59x: Disable CONFIG_EFI_LOADER
Message-Id: <178725214508.2214048.11481613963178927010.b4-ty@konsulko.com>
Date: Thu, 20 Aug 2026 12:55:45 -0600
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

On Mon, 10 Aug 2026 08:21:36 -0400, Caleb Ethridge wrote:

> From: Caleb Ethridge <caleb.ethridge@analog.com>
> 
> The sc5xx boards do not use UEFI support, so CONFIG_EFI_LOADER
> brings in unused code in the build. This is already disabled for
> every board except for the sc598 and sc594 variants, this series
> extends this exclusion to those boards.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] configs: adi: sc598: disable CONFIG_EFI_LOADER
      commit: 5c8c261ffce995bc5b7edcf958630903eeab4207
[2/2] configs: adi: sc594: disable CONFIG_EFI_LOADER
      commit: 0fe8d8389a366ed3a368be8f508b766a0bee73ba
-- 
Tom


