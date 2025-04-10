Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0110DC369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 17:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97D6C839D9;
	Thu, 10 Apr 2025 19:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y9qSG1Kj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77CD183D9C; Thu, 10 Apr 2025 19:34:01 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37D8283DBD
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 19:33:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3fcfc85f1f5so325823b6e.2
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744306437; x=1744911237; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OIL2uxnT32S21qPAEf9WCO22S7HQzITpt4aP7dbgR98=;
 b=Y9qSG1KjBUZpB7ax0H9hyCz0HBiBIlJH3iLQw37C+wXljpfjbJMmluzYgZlaoLSHN+
 Xrgq5Az0vN9222olnVz3aDhOqHAPS6MKOvNYI/yeFV9H7lnZcB9eW5v1WwbSX9qgkKiQ
 zQ34UJrWxlWj784wafrVQaaTIScyFRO0JHeRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744306437; x=1744911237;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OIL2uxnT32S21qPAEf9WCO22S7HQzITpt4aP7dbgR98=;
 b=dmQbJ8T8bluj+HHbbOVpW8bWewSbd6lMHA9/qMWGmeFaUmoIThnkl0xMzZ1HLNGjzs
 TeAC1DjA6pIWGrfsoy83V6/36x2XFfDGP/4GKl8ilM23rDJTX/+Pp5NmCZtN4de/kvjI
 GjDQunTfpG7NSxvuEFTOk4cnuHY1k8Uv2am2p278/d2Ts8AGzF7ITWRtG9PT2DdLYsJr
 Y3jw6m1s2vaTppwN8jQlv/Nfa3WgdGrf0qj0ClBFahbwRb9CWlGz7LSs5lDwYHqcx/ka
 NrwccH9RZqXJI/2x1ojYQP3vqECAK4zm+vqz6GQ9htQuqkHrPDcnVWEzb74SeYHmxCzV
 RHtg==
X-Gm-Message-State: AOJu0Yy3BAxnmeBEH9CfuIRvBm8OsS4UPO/NfTmiAu+bnx4aHeDkgYku
 OiYRynZRc1i6VMFoDt6FI2NTuGTpdyUHqAe3Fouz9ZP+oJUORV7J6F1vri0mzR50Po6zN3SNqm3
 Fk0E=
X-Gm-Gg: ASbGncvlfj1UUg0CMm6U6/39EQOBmycD96ej/acKkwTanIjW7OmOaOyrm8wJ5gwOaSX
 qEP2Jzz518bAnkFDBPSKCg/0swWavvQDU4vD70V+fZ3f5xr4w3PtEVI6J5utL1o8XrJIyniySHt
 GoRc1Dv68SmmmPp/GmOsFPrkOMVwlRvC890RUdjhgFwulf5e9ziTOlRI7P0DS2nNnM4RhdDfZLP
 mLLU25jyHJswvLFPehInOnpZfvbh0NYhlFLoUZdb4ztLW0zVcLriNw1clqPFkaQ2bG2+2PoJMnv
 kZVeQLeShnN5DgCB4SCFqazau7s2JDCMaB5rDDFQNBYDlo3i8sdp1YYAiHUqqrKeoQAL031tvyc
 igg+Ukz4YgJg=
X-Google-Smtp-Source: AGHT+IGDqa5NRswXjIPm4sRJxqbqYxITolSjJjNLmfw6n9EOChvdfVV6isw/FKrfio5esp6XkBnSoA==
X-Received: by 2002:a05:6808:151e:b0:3f9:bc8f:8145 with SMTP id
 5614622812f47-4007bba67cbmr1746276b6e.0.1744306436813; 
 Thu, 10 Apr 2025 10:33:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40082515ebesm75008b6e.11.2025.04.10.10.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 10:33:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250410165403.2955751-1-trini@konsulko.com>
References: <20250410165403.2955751-1-trini@konsulko.com>
Subject: Re: [PATCH] Dockerfile: Add fdisk
Message-Id: <174430643624.2959201.8844901452982646125.b4-ty@konsulko.com>
Date: Thu, 10 Apr 2025 11:33:56 -0600
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

On Thu, 10 Apr 2025 10:54:03 -0600, Tom Rini wrote:

> We had previously gotten this package through a chain of dependencies
> with guestfs-tools. Now that we no longer install that package, install
> fdisk (for sfdisk) directly.
> 
> 

Applied to u-boot/master, thanks!

[1/1] Dockerfile: Add fdisk
      commit: 970cd1319a7867f8dfe8f7644b9fa773ccce9149
-- 
Tom


