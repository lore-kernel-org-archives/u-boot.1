Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED54DCCF2C1
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:24:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2F6261168;
	Fri, 16 Oct 2026 13:24:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G9lzlpZTblvB; Fri, 16 Oct 2026 13:24:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8E83661329
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792157079;
	b=tOrpi3+s7hIbw/elFSJo4Pq99/ArhvpN9exh5oYp1FqQPnqM/X+VZHyoTBis/EN7dBco
	 TGslsEeuaf343+Lj0EhJblelL1KGy1hWlYm8G9ELBy6uNi+5uAnntFtZqlCOAIhgpSXv/
	 O6zVIjqmPH1eiWK9jWTmIjXKe1dKQPjTa/EFPJgvyToqsZ466XHYRLc4oU94x/Owxorf+
	 T7DNYkeYqt5c7vaLoJ0WrQW/dJlcjKMtW2ll/hR0qV4xqsMPzIczcFpAIXSlJ4oI7tFij
	 la2jtv0koVn0u6LzOXYuYNSwAlUs7gR63LjPcpTQOw6/PzO7Svj7Bw35VyMQTOKyRjA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792157079;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2a6yOpjZL+dJUHuxHl/yz+FlSqMkJtteMyGz7mazCzM=;
	b=NWy6RmSF/3I0Ay9FJDi4w4sG1L89/sDeoP1+SmNhg1QUWf4gXTimimkVgTNBR4QzTa9q
	 pwojf+cEkVkK7tc1wt8dUXwVnjE3v+qVCg4riGAhKHU691ozlrFj7VVEkl4E9mfzAzVhV
	 aP2od7uOeqFUK3BzDy+i25O1FdUxdpkTmdm593b6tJU8WDjAYQ1nE2rcsWZLgbaXJLmIJ
	 claHlVNzxhsOB3lbCcHnz8N80030XU439z8lpLP+7qaM83g9r8i0OH67m0D8uUs4azCct
	 54zlGFrY/bKdY0RqL8qldtIKlDz7ykHZdDryehct5WmGRaUdbmsm81XOoGLMzcs7yrA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=OEO4FEX+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792157079;
	bh=2a6yOpjZL+dJUHuxHl/yz+FlSqMkJtteMyGz7mazCzM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JR5+7PtgvYC760zXi8U2j0ga0jX4xJ7jbiy6Zsr75mScafJZgAm2P+Tnor4QLBUsn
	 M+frYaBfDH+xfRybCccnKpwTrDHAj9sCsEMlKzpDsCvrXx+m6fM+ZCZMQaevPz3/iy
	 BIBU9SO/O9Lx5Zb3pbD3gzO9AZnox175K+YFRGgefiW4pL3xU16WHdM637jB1cDiQm
	 zjEr+BgNwP/zLAbvUmotAV6snY+abGz1vcWiLHTgyl/H6dLXpuK7cxXRZggy+gF1f8
	 dlYCoUygDvjC+hC3M/AIhTQ9EVcNDPsFHtjlQNRukAbG+t+CaUvGWfUIvWmEPbPjtA
	 9nMu2XqKEVTGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E83661329;
	Fri, 16 Oct 2026 13:24:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D470105
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:24:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E67856079B
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:24:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2euemv1INvSm for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 12:24:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 61F15606B9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792153487;
 b=KUOzq/CG7hF39lMGps8wE85OV6fsAw8OGlPa1Cnqv2wEtHmCMWPu6P4lXhJg02bcbfQR
 zv3Eeo+dOgfMrvbaEGcT2z5yysng3n3IeZzRTj41oJ8a7svklri9OTKdV0qvm15GEG4jJ
 EKUxjMvW/S1KN52VV9zssYt6NAQGUSpmQomkyvXZMGNJjUOmoGZX2ABvCrt+IS7Cu3sod
 Sdemdcezp3OW/Ok2K9HP8zVFNIVLHE0iChhenVIzTSV70IA640i+MIhWia8cgZfy29Qo0
 wA0cgECcFW9jWw7KYlaEiywVMWprWgoUGWRysygKHSOEPvhU1A6KzjJtlcx8xfcOOAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792153487;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=2a6yOpjZL+dJUHuxHl/yz+FlSqMkJtteMyGz7mazCzM=;
 b=az6f8nR9OPfDyRPFGN4mw4XrgQoB/jJM1uFLip2hV1KwO6QKNAjf4D+wwxVW9jJ4NTwu
 fx5mXykVckw0oqQ6b8jt5ZShIOORTqTd4ydkCoewFl7OedTaqV+v7IWVZQXVqF5fkoVT/
 3BPQGHA6BxCa1X2eRQatgJnpkgMJ2XgSWqNFOoQBnP85nTkPYjJSyN4xyBiquhoyDhVxJ
 XkZJ3TvUiKgLcVJN1fYcv7LDntwaEqx8I91kFMNvdx4QMbTrwW0A18apnREf6RrZN4009
 VmTFscj1Btw6FILrO89eejqNSyW9h8/Uc43kbXwczZJbezCdgKl8xFmerMvjl2dSYYQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=OEO4FEX+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=OEO4FEX+
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61F15606B9
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:24:47 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6afbc363efeso5051656a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 05:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792153485; cv=none;
 d=google.com; s=arc-20260327;
 b=Fti6PLBdZ0WmbywMbku+z0GoVIwzpQbatz9iy5llwr9n8u+eIggvpCM3J/uSZ4p9Fp
 FMPewLtRwN80nBSeCoJ8arabUaYd8DlL3v6I2AVGTQnmU2l7t21xnben2Qi7Qaoupibg
 OIBuBPE88BOLKSnIQKSB3G+iK0kVYHHDo8ku4kqPc6Be6qtP377AwicyRwXiP9TN3Bug
 EOMVpjGY//9EnRNnxsgRBKp7okb3Z6ZUjSpKc9DVfNOcUCyKfVlwFiTF55YucCLy2fcc
 vz2KhTp1dT5m8EJc31ARJ9tT0a2vh5Q6scOrUcPmX0efovm2hiSLmY8t0DRcx8jj+eZx
 mWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2a6yOpjZL+dJUHuxHl/yz+FlSqMkJtteMyGz7mazCzM=;
 fh=DTjM5Uha1SlnG49flEhOrWmZqiqlxQhcdk4kuVoSJf8=;
 b=h/5h5kmAlMyygkFgR5eXKQypnMTmoBhf3Vxw+qQGp8E0ZQ3e5QURTWv5MyY4inT+/v
 x6j2gF8+CRXyAsqb31B0S18c3F/xzqBjJiahX11NhQOfUdhxwPcBCFUQONXbP+tfjgkT
 vZfmoSLz4QlFn/MsteE/Yg75Yap8/CQI4vuk8M8J1cczstSfte42mW7K4ROSdJW9iO6I
 OS5Te0HT5SPZipZKtEgEf6DuJwOd7j/7X9W+boIZv0KENATVQQIyN5cbkcgAVQ13qAuT
 XZYywxE8egJ0E+vYJsoB8dGDnQY2uEWM3YZMGgZDvUVDfEoqGL07l01+m2oJrLVD32uh
 0ZAA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792153485; x=1792758285;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2a6yOpjZL+dJUHuxHl/yz+FlSqMkJtteMyGz7mazCzM=;
 b=OEO4FEX+T8ROVt3OmjNin7pPEvxZeK8ycEEyGQ0vA35O3Dz7GZeg5GqaHEgKX3Bi7m
 gZ497lEGTJRLEFX6dZQJ4TLpcPeLi7DMgtzl/FfzDFUcfrrXYXQ6be1t1aLRukGZLBEj
 vwaO9Af0n5yW0xW0McBDLcMgJjBIZB/S+uwothNknTVfPVzlzvHl6zB42QVSKJtYiPAp
 F2etX/CsPKzkPo+rOpPLYgEqzX/t3R6y6lNmhiv7GsOqj4pGWH6aMoj82jbEmzPNsJhG
 BXPkeB5GlegDDdCtl6IVbs4sSnB2HjfYq020abeZXo7wSCPOiLOcN5kzLUo0NHnMe/0e
 lE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792153485; x=1792758285;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2a6yOpjZL+dJUHuxHl/yz+FlSqMkJtteMyGz7mazCzM=;
 b=yjCUKSHV9a8WrHVh0i6Q+r2rDdFvDqcOsfi6ZY6MA9HWSo7wpqW3vEk91SkAkuRR61
 cOg6l15J0L+WsoYtXhQ63WDWQhditIg+nXymdhu0OpEpiWf/m5eUArX1Hcbkwa6ON6mM
 ms8ZRH/Q+jepdt1fUKsBou9wDNZwDe1F4ztViH+bb97zpwT2Fe+8HkejvzKJyzlOlhAj
 +F5UgxWLf/0PiiIVS4Y9fpcdp4lBxqtUsJiRgP9GZQ/PmXkhT3QkQybE5r+xKMQ96inR
 w7K3140uE1dxUF0jhyt4BdkSlYI4QYB04atwLAPYaIvIXt1IZg0MrHCUit714ve1VlWD
 pvWg==
X-Forwarded-Encrypted: i=1;
 AKwUvByD5j+qvP5MrHH/MSzbTvVKX+QuMQw/4R58l8AJVXG+X53xBoO08WJDISeskE4rppCUkbFLi3A=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL09Fb1hMdRpQxaMtztebr7BCoJYhwpfWektkxhBEpzQbs+MvJ5
 GYpywjFh51vlhAboTqAhEF28Uzq7ynvLRUPthJ1m5Tj5GaLdCNQv+HR9OC1k4S/P11R7gQdKSMu
 X47eJF/kHtgNi8lSqGVlrlJPFtJUMnPHLaMoKIl3EEA==
X-Gm-Gg: AYBFou2YrveqQ53NuAgepBYJ/eh9P5VO9OkkqS2r6HMsG3BzzsHxC8SPc+AhV396JlN
 DxipxWOfkZ5RDFNNLPNdtQXlu8YFHGMHKxMhpEjWj2Adt+4YVuqzmGwY++D+1Em5kgoutIxpnbn
 BsvLncKPREVtqkyhsVLjbr6Kz7iinNMtAShKpoCMObSbWz/VVRX0aj9OEeo5vYDtSU3gp0pWXfQ
 EvAc3Yh0NI5wf6T4lEZTC4xLoNf4MrXfKzT0vmPZ7WIJg0UopLWoxNgKGGabdlUgWzoITz8k+6j
 A+eK2pcDbfNlUT+w8AcbDXRuQboXbTauVE2YzGU7uuju8ZvHmvJez3y28rtljs5O9+8iyovzbS/
 8hHIgstFHS193
X-Received: by 2002:a17:907:948f:b0:c29:5899:484e with SMTP id
 a640c23a62f3a-c31a9d15b2amr2044042166b.23.1792153484825; Fri, 16 Oct 2026
 05:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-6-acb97c172993@flipper.net>
 <00e2291d-7fc5-4ea1-abb2-9b9100a2b680@cherry.de>
 <CAKTNdwFMCK2frVyrmYWe67k6WgjA7pmJn-SbU+_9NtceHqHERw@mail.gmail.com>
 <6ea99943-eb9d-43a8-a238-edbc1b9c767d@cherry.de>
 <CAKTNdwELO46dZ1Cy+-wpBbQNsP9XJyTgCjBYLQpE39YJ3XP0wg@mail.gmail.com>
 <e7235ec1-dff2-44fa-8c02-9b6a1012bba6@cherry.de>
 <CAKTNdwEgVRZVFr+V8jCwQmJES7PO3WgdBa5es4EkkOy50xdkiw@mail.gmail.com>
 <1cc78fcf-bc97-42bb-ac67-792ad047adc0@cherry.de>
 <CAFLszTi_8=bK=gLEEadunTLumaGo8L8enYovxFadCyzPXorJiQ@mail.gmail.com>
 <5ebfc286-47e1-4151-a51f-2620031838ad@cherry.de>
In-Reply-To: <5ebfc286-47e1-4151-a51f-2620031838ad@cherry.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 16 Oct 2026 16:24:33 +0400
X-Gm-Features: AclHuK-bfxxDCiKyTPJARVrCGQvCs5M6G7o0Lt7EBSJDHqeFOiBqbTzpuV_dMds
Message-ID: <CAKTNdwE_J+3bMjz6uwd_Wz-szaMYwC1-n4wrYEuSF-ktBLriXg@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] binman: Add support for pre-patching FDTs in a
 FIT with a /chosen node
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Davis <afd@ti.com>, Hrushikesh Salunke <h-salunke@ti.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:23:56 +0000
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

On Fri, Oct 16, 2026 at 1:52=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Simon,
>
> On 10/1/26 6:13 PM, Simon Glass wrote:
> > Hi,
> >
> > On Tue, 29 Sept 2026 at 13:03, Quentin Schulz <quentin.schulz@cherry.de=
> wrote:
> >>
> >>
> >>
> >> On 9/29/26 1:03 PM, Alexey Charkov wrote:
> >>> On Tue, Sep 29, 2026 at 2:29=E2=80=AFPM Quentin Schulz <quentin.schul=
z@cherry.de> wrote:
> >>>>
> >>>> Hi Alexey,
> >>>>
> >>>> On 9/28/26 6:44 PM, Alexey Charkov wrote:
> >>>>> On Mon, Sep 28, 2026 at 7:53=E2=80=AFPM Quentin Schulz <quentin.sch=
ulz@cherry.de> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 9/28/26 4:03 PM, Alexey Charkov wrote:
> >>>>>>> Hi Quentin,
> >>>>>>>
> >>>>>>> On Mon, Sep 28, 2026 at 5:26=E2=80=AFPM Quentin Schulz <quentin.s=
chulz@cherry.de> wrote:
> >>>>>>>>
> >>>>>>>> Hi Alexey,
> >>>>>>>>
> >>>>>>>> On 7/31/26 7:10 PM, Alexey Charkov wrote:
> >>>>>>>>> When a generated FIT is used to boot Linux directly, bypassing =
U-Boot
> >>>>>>>>> proper (Falcon mode), there is no runtime code to discover the =
kernel
> >>>>>>>>> command line and (optional) initrd location and include them in=
 a FDT.
> >>>>>>>>>
> >>>>>>>>> To facilitate easier preparation of a ready-to-boot FIT, add su=
pport for
> >>>>>>>>> pre-patching the FDTs in a FIT with a preconfigured /chosen nod=
e including
> >>>>>>>>> the bootargs and initrd location.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> This sounds wrong to me. Why should we hardcode those at build t=
ime? We
> >>>>>>>> already do DT fixups in U-Boot proper *at runtime*, so we should
> >>>>>>>> probably do the same in xPL when booting in Falcon mode instead =
of
> >>>>>>>> hardcoding stuff. Since you're aware of this, I'm guessing you d=
ecided
> >>>>>>>> against, but you don't tell us why. I'm a bit worried going with=
 the
> >>>>>>>> suggested implementation means we'll eventually have a binman no=
de
> >>>>>>>> property for each DT node/property we want to write/override.
> >>>>>>>
> >>>>>>> The "regular" Falcon way of doing things (i.e. the one not involv=
ing
> >>>>>>> TF-A) has so far been: "capture what U-Boot patches into the args=
 to
> >>>>>>> be passed to the kernel, package it into a fixed binary, and boot=
 only
> >>>>>>> that". No runtime fixups. So I more or less followed that pattern=
, but
> >>>>>>> tried to make it a bit more accessible by eliminating the "captur=
e
> >>>>>>> something at runtime and save it somehow somewhere" step, which I=
 find
> >>>>>>> unnecessarily painful.
> >>>>>>>
> >>>>>>> Maybe runtime fixups could be brought into xPL, but they are
> >>>>>>> excruciatingly slow, whereas speed is the main reason for wanting
> >>>>>>> Falcon mode boot in the first place. Right now with Falcon mode o=
n
> >>>>>>> RK3576 I'm getting 2.5 seconds from applying power to _userspace_
> >>>>>>> (i.e. full graphical UI drawn on the screen), whereas the best I =
could
> >>>>>>> get with U-Boot is just over 3s to its boot menu, much of that ti=
me
> >>>>>>> spent going over the flat devicetree before relocation in O(n^2)
> >>>>>>> passes. And those 3s are after stripping the massive pinctrl node=
 with
> >>>>>>> hundreds of its always-present children from the pre-relocation D=
T,
> >>>>>>> which alone saves ~0.4s.
> >>>>>>>
> >>>>>>
> >>>>>> Are they always present, even with /omit-if-no-ref/ instruction? O=
r
> >>>>>> maybe you're building the device trees with -@? Trying to figure o=
ut if
> >>>>>> somehow we have a bug in dtc (or in our scripts making use of it).
> >>>>>
> >>>>> The problem is that there are a lot of `status =3D "disabled";` dev=
ice
> >>>>> nodes referencing pinctrl nodes, which keep dtc from dropping them
> >>>>> altogether, so a lot of unused pin configs end up in the binary -
> >>>>> enough to be noticeable in boot time.
> >>>>>
> >>>>
> >>>> And we cannot really get rid of the status =3D "disabled" nodes as t=
hey
> >>>> may be switched to "enabled" for some reason at runtime by e.g. U-Bo=
ot I
> >>>> guess? I'm wondering if this (stripping all nodes which are disabled=
) is
> >>>> something we could still allow (e.g. gated by a Kconfig symbol).
> >>>
> >>> Yes, stripping those entirely would break DT overlays and runtime
> >>
> >> Base DT for overlays need to be compiled with -@ so you have all symbo=
ls
> >> available, this is something we could detect (presence of /__symbols__
> >> node IIRC) and bail out...
> >>
> >>> board fixups (e.g. what I do for the Flipper One to switch between
> >>> SATA/PCIe pin modes based on the M.2 key B config pins strapping).
> >>>
> >>
> >> but that would also prevent that kind of things and since you actually
> >> are already impacted by this, the hack I suggested isn't appealing any=
way.
> >>
> >>>   From what I understood while investigating those boot delays, it's =
the
> >>> linear FDT representation in (uncached) pre-relocation memory what
> >>> kills performance when the count of nodes grows to real-world numbers=
.
> >>> Having a more efficient data structure to hold the tree
> >>> pre-relocation, or enabling D-cache pre-relocation, would both speed
> >>> it up considerably - perhaps more so than trimming the tree itself.
> >>> But going down that road sounds a bit scary.
> >>>
> >>
> >> No experience with cache so big scary word to me indeed ;)
> >>
> >>>>>> Don't we have FDT and DM in SPL anyway as that's how we probe driv=
ers in
> >>>>>> that stage (not counting the few SPL-only boards we have)?
> >>>>>
> >>>>> SPL's DTB is tiny due to bootph-* markup (it was just 27 nodes last
> >>>>> time I counted for my RK3576 use case). Making SPL parse the whole
> >>>>> OS-oriented device tree, along with all the relocations required to
> >>>>> insert stuff at runtime, will hurt.
> >>>>>
> >>>>
> >>>> Ah yes, missed that.
> >>>>
> >>>>>> I don't have anything better to suggest, I'm just really worried a=
bout
> >>>>>> the potential ballooning of properties we need to mirror in binman=
.
> >>>>>>
> >>>>>>>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >>>>>>>>> ---
> >>>>>>>>>       tools/binman/entry.py     |   8 ++++
> >>>>>>>>>       tools/binman/etype/fit.py | 103 +++++++++++++++++++++++++=
+++++++++++++++++++++
> >>>>>>>>>       2 files changed, 111 insertions(+)
> >>>>>>>>>
> >>>>>>>>> diff --git a/tools/binman/entry.py b/tools/binman/entry.py
> >>>>>>>>> index ce7ef28e94b1..e0dea8bf3a49 100644
> >>>>>>>>> --- a/tools/binman/entry.py
> >>>>>>>>> +++ b/tools/binman/entry.py
> >>>>>>>>> @@ -636,6 +636,14 @@ class Entry(object):
> >>>>>>>>>               self.Detail('GetData: size %s' % to_hex_size(self=
.data))
> >>>>>>>>>               return self.data
> >>>>>>>>>
> >>>>>>>>> +    def GetNode(self):
> >>>>>>>>> +        """Get the devicetree node which describes this entry
> >>>>>>>>> +
> >>>>>>>>> +        Returns:
> >>>>>>>>> +            Node: Node for this entry
> >>>>>>>>> +        """
> >>>>>>>>> +        return self._node
> >>>>>>>>> +
> >>>>>>>>>           def GetPaddedData(self, data=3DNone):
> >>>>>>>>>               """Get the data for an entry including any paddin=
g
> >>>>>>>>>
> >>>>>>>>> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit=
.py
> >>>>>>>>> index 32caa03a7e16..750ff5b47ed5 100644
> >>>>>>>>> --- a/tools/binman/etype/fit.py
> >>>>>>>>> +++ b/tools/binman/etype/fit.py
> >>>>>>>>> @@ -304,6 +304,40 @@ class Entry_fit(Entry_section):
> >>>>>>>>>
> >>>>>>>>>           See :ref:`fdtgrep_filter` for more information.
> >>>>>>>>>
> >>>>>>>>> +    Patching /chosen into the generated device trees
> >>>>>>>>> +    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>>>>>>> +
> >>>>>>>>> +    When the OS is booted directly from this FIT (e.g. Falcon =
mode) U-Boot
> >>>>>>>>> +    proper never runs, so its usual runtime /chosen fixups do =
not happen. Two
> >>>>>>>>> +    optional properties on the `@fdt-SEQ` node make binman pat=
ch each generated
> >>>>>>>>> +    device tree at build time:
> >>>>>>>>> +
> >>>>>>>>> +    fit,bootargs
> >>>>>>>>> +        A string written to /chosen/bootargs of every generate=
d device tree
> >>>>>>>>> +        (any existing value is overwritten). Typically set to =
`CONFIG_BOOTARGS`
> >>>>>>>>> +        via the preprocessed devicetree source.
> >>>>>>>>> +
> >>>>>>>>> +    fit,initrd
> >>>>>>>>> +        The image name of a loadable (e.g. "ramdisk") to use a=
s the initramfs.
> >>>>>>>>> +        Its `load` address and packed size are written to
> >>>>>>>>> +        /chosen/linux,initrd-start and /chosen/linux,initrd-en=
d (at the width of
> >>>>>>>>> +        the device tree's root #address-cells) and reserved in=
 the FDT
> >>>>>>>>> +        memory-reservation map, mirroring fdt_initrd(). If the=
 referenced image
> >>>>>>>>> +        is absent or empty (e.g. an optional initramfs that wa=
s not supplied)
> >>>>>>>>> +        the initrd properties are omitted.
> >>>>>>>>> +
> >>>>>>>>
> >>>>>>>> This sounds wrong, why would the FDT image node need to know abo=
ut which
> >>>>>>>> ramdisk may be used? Shouldn't we rather have a ramdisk property=
 in a
> >>>>>>>> configuration node, and then patch the FDT based on that informa=
tion?
> >>>>>>>
> >>>>>>> Falcon mode boot where these are useful is for a fixed-configurat=
ion
> >>>>>>> boot flow anyway, where one wouldn't have a way to select among
> >>>>>>
> >>>>>> How do you plan on doing A/B with Falcon boot? How do you know fro=
m
> >>>>>> which partition the kernel you booted originated so you don't upgr=
ade on
> >>>>>> the currently booted partition? There must be some way for U-Boot =
SPL to
> >>>>>> tell the kernel at runtime where it came from?
> >>>>>
> >>>>> I don't currently do A/B with Falcon; instead, I rely on the fallba=
ck
> >>>>> to U-Boot, and U-Boot in turn loads from a UFS boot W-LU (which is =
A/B
> >>>>> native). Making A/B work with Falcon would be a nice follow-up, but=
 I
> >>>>
> >>>> This means supporting two completely different boot flows with poten=
tial
> >>>> side effects (U-Boot proper probing/breaking stuff while Falcon mode
> >>>> doesn't).
> >>>
> >>> Yep, not ideal. It's all heavy work in progress, so I might still
> >>> rethink the whole approach more than once :)
> >>>
> >>>>> believe it will require some external metadata to choose the active
> >>>>> boot source anyway - and then the same external metadata can be use=
d
> >>>>> for the upgrade. Such as the UFS device attributes, or whatever peo=
ple
> >>>>> use for RAUC and such.
> >>>>>
> >>>>
> >>>> I guess you could use a U-Boot environment for that or some more sec=
ure
> >>>> location (via OP-TEE/TPM, etc...).
> >>>
> >>> RPMB with the key managed via OP-TEE backed by hardware secure OTP an=
d
> >>> on-chip crypto would have been great, but it's a mighty detour from
> >>> where we currently stand, so I'm leaving that for desserts :)
> >>>
> >>>>>>> several ramdisks to go with the kernel image. So putting this
> >>>>>>> information directly where the user (i.e. the kernel) will find i=
t
> >>>>>>> cuts out intermediate steps, which in turn improves speed and red=
uces
> >>>>>>> complexity.
> >>>>>>
> >>>>>> You already have:
> >>>>>>
> >>>>>> fit,firmware =3D "atf-1", "kernel", "ramdisk";
> >>>>>> fdt =3D "fdt-SEQ";
> >>>>>>
> >>>>>> in the configuration node. So simply have binman derive from
> >>>>>> fit,firmware which node is included of type "ramdisk" and fixup th=
e
> >>>>>> device trees in fdt-SEQ based on that info? Less user-prone IMO.
> >>>>>
> >>>>> Ah, I thought you were referring to runtime FDT fixups based on the
> >>>>> selected configuration. Patching it in using binman based on the
> >>>>> configuration node contents should work, too, but what's the practi=
cal
> >>>>> benefit? It would still use the same ramdisk node, just written in =
a
> >>>>> different place - or am I missing something?
> >>>>>
> >>>>
> >>>> Not written in a different place, written in the only place it alrea=
dy
> >>>> is, removing the need for duplicating the info which the user should=
n't
> >>>> have to do.
> >>>
> >>> I think I start getting what you mean, let me see if I can indeed mak=
e
> >>> binman infer which "ramdisk" should go for "ramdisk" and write the
> >>> attributes based on that :)
> >>>
> >>
> >> I'll try to be more concise/explicit next time. Trying to review too
> >> many things for different projects at once at the moment so I sometime=
s
> >> just do "brain to fingers" without putting much more thoughts into it.
> >>
> >>>> Re: fit,bootargs, can't you simply have the property included in you=
r
> >>>> -u-boot.dtsi directly, so we don't have to have yet another binman
> >>>> option? I understand this won't work well if we separate binman from
> >>>> U-Boot like talked in a different thread, but we are not there yet.
> >>>
> >>> That would mean rewriting the .dtsi every time the bootargs need to
> >>> change, which in this setup is just an (already existing) Kconfig
> >>> option. The property is also not useful for U-Boot proper, which woul=
d
> >>> inherit it via -u-boot.dtsi. Plus, I'd rather not make the whole
> >>> Falcon thing too board-specific, as then it makes trying it out on a
> >>> different board way more pain than strictly necessary.
> >>>
> >>
> >> You could reuse the Kconfig option in the dtsi. But ACK, no perfect
> >> solution it seems so far.
> >
> > A few vague thoughts:
> >
> > 1. If binman finds the ramdisk from the configuration, note that an
> > FDT image can be shared by several configurations with different
> > ramdisks (or none). In that case there is no single correct /chosen,
> > so binman should probably raise an error rather than letting the last
> > one win.
> >
>
> Mmmm... true. Thinking out loud but maybe generate a Device Tree overlay
> per configuration then? Maybe a "bit" overengineered though.
>
> syslinux/extlinux "standard" supports[1] multiple initramfs at once,
> does FIT as well? This makes things "slightly" hairier.

There should be a single pair of start-end addresses for the initrd
passed to Linux in the /chosen node, so any "multiple images"
arrangements should eventually collapse to a single contiguous
concatenated region. In my WIP v3 I'm making it so that the (single)
ramdisk image node can reference any number of blobs (which binman
will concatenate), but the image node itself should only contain one
load address, to which the combined size will be added during binman's
processing.

Best regards,
Alexey
