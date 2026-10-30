Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB5606A321
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=J5pivubo;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kKPGlhUq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8235E60668;
	Fri, 30 Oct 2026 14:35:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XXLdVlRaD8ja; Fri, 30 Oct 2026 14:35:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AC37A60AA2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793370954;
	b=Iy3nPYV0PtoCiw3TTN2Pyi/HaoZ/JCOVRSLrUb8Ldw2e8TwwosHguai3NVMQUV6Jb18l
	 Ch5SPyXaOcl0bxiuiXyBDPF4x3vj7YNqMqaoNv0wi0BKRmRblVHaW8AbJjtqsGiSodBmE
	 26qUYBuTlqielSJS8dpAfH84neXP3KOyb66Xrm8kIUN9IgggzIPdysVTYfI1/F1LXg1pH
	 WypEercHisnzZ/AeVlLXNC+zBEr0G9aKfPk4bKUnMBZvNED3NwNLSff7zGyvQaiGOXxCV
	 wh4PLdmiPNKN6TRY3DCJywT3erya26tlBdLvN0edncx63HHOqy7sEeuylTZ346211JA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793370954;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Kx1yTONtdT1WvrzoMw7jdhyBEoftaRLlL5uhBP5tWQk=;
	b=JiT5Bq90XXVqX2nzgON9l0xwOlwzSbrVErmwc12F5bYnFXR2/KseQHluNozDmDu0e4iF
	 eIbJsNoO/066Y/qhWuhlvF+ByGnt+qoEAV/CmkOAioqmMHgCFmeu4K6fPXeM2XgP5ATXV
	 Wd8q7nKZ78oZiNxD5fJoDvwwrXAzkaB5lAjfK/+USHfUCFfyrZkcgZeRTHTjYRztoaT7C
	 LqHfWaAX0KDE95Xw79sxhuBc2TUfkobgTAIDf/rCFsw/SZcB7Wm1ykfNztAgom7yn9zuC
	 MSoMl9+0Q2jxcxqDBQV7EoGI8xEZ8+X+oqMDuiDQTsjUCSx1HFu0XgfM57lR50QYvag==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793370954;
	bh=Kx1yTONtdT1WvrzoMw7jdhyBEoftaRLlL5uhBP5tWQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J5pivuboZ00wty04G4Mu9Gr6WkaxACZirWlgkcsC9Png4f42pRiXkhYKWqr/d1jQG
	 AHGhhANJxF2szLny4rslRgigd6Y6yahADwxAt+0Grf/VTmIZd2/1b8tathHWbDumnr
	 rxMCMWN/mqaj81au2RdghTO0X5tNED2hLCfFx8Y+YgwNBCZ2/Lwx5Bn81CveSj7e4s
	 0oJWdVIEdRXpmc6hPF29x2eRcxKpjMuiGE45lqNY/z+iVSf2S9hQHGM+faSQ/BUe+D
	 8P4JE6sfp3ev8fHudT5JIM1Eq3R5SGze7i2Tda4scyYkxsg6MskqTWaSCcJvvDWKkF
	 HW2gFX5Ab+fLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC37A60AA2;
	Fri, 30 Oct 2026 14:35:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F5B92AC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CDDB40C82
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:35:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D7sXpSD59JP8 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:35:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2C42C40C76
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793370952;
 b=VCdZztb3OXk2Ac+9dsZzDSkkUKG5EjQYQ3PmjMG123SV3GFz5CVwlFcFmIJoL1gRw2zL
 ryfr9KGLK7kCcQtSvsTQeDG2fcVQ4ae9juG5gUBJ3+cZtaKPMN8RDiKitMJGSycoO7oOr
 EcMW5iprDDW62dkEav+xmrsfEu0ym1L6zHayPHrb56Lj+MIci3/yU0+X9noyxFBNGV7wM
 lRkIDHZgoPH+VKlGB4RhzpgSjTvX4JzwC/vsFq8JQGeRVA7+8RQvdbvDANACXXhWgPPqd
 yRKC4/63GPRtQ7nEiaWt9NZDImX5lfDP05qnoQ/0NcHA1yF+MEkqdsWDBLD82rMw4MA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793370952;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=Kx1yTONtdT1WvrzoMw7jdhyBEoftaRLlL5uhBP5tWQk=;
 b=AK4OLqHoL7zqvy23nSxgntVl2T8/l8sz+M3xKQaGiWt0l+gr55qdtOUgqG/f71h92fOa
 BUrDe+NPOpkR7sajRq6SsxPuqW0wl6/zlS4ZjnuDJPYqFnRMpQvShm9+ut76+BEnie0vt
 Wm0MYSKALmDM5DO1i9x2nqY/SLUyC2fXHw1bd8ctfQ9jvqpURyM2Pv3FPVEeZ2vcLoIxN
 kXOeOM0xTuXMboic+xEiXlnbh/O21U3R8Axui6CbdqcKfb7dZaN5cjCqA07YOipk5rdjs
 S8FKPZvCvZCVQ47tCTNlK4F9LbY/QRxb1XQ/L6ymw7lUMPrrCTE2WBkwLphhiyE29+w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=kKPGlhUq; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=kKPGlhUq
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C42C40C76
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:35:51 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so6572995e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793370949; x=1793975749;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Kx1yTONtdT1WvrzoMw7jdhyBEoftaRLlL5uhBP5tWQk=;
 b=kKPGlhUqYXQvuLsFoU5n2gCVpK3aa3LGtoOAWZMYbZ9tVN+fs/UlJTWYzA1WtzXRxr
 cEICJ8FTfqucv2/F6PP5F1uNbT7WYW5T1HNwyPHLBv0P6Lsb5hiJHWN5VuqGda/MOi61
 RkjUnhIctK5pEBoVNRV+eF8g7MAhA/x99SbbmGOxa1lchQFIPZRpfc8eaU7xDV3anSgg
 /ylroItyawnMw8ryOnmyKaofrJ8rdJVAg/OoadNBDbSsiGy/R6HsYHiTv5MigFpYXyDW
 ue2aDL6hQGW8JmzIT1whtYfdz3OubQU5EMS7MCwUcbbfUsBZG7FZLHltEQ2kZJZbdpWw
 8H2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793370949; x=1793975749;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Kx1yTONtdT1WvrzoMw7jdhyBEoftaRLlL5uhBP5tWQk=;
 b=nIg8hb6p7D4tk1pDSowllDPtr/LJVauRQv8wmxeyotq05xJbcJKcBzkLHFAWn2Yweu
 aZ05vvs5vkrJoZOKGVnpzeYaKwTja7hp3gOGOgKGkh4weDof2G7BglNurKsHURmF3bko
 K1duPXulwTCO2b2IvyQtrnf+AAazzDKn3y/BK7C2pngum880ErzQGSebjxi/7uop6RvT
 Q5WFgFcXh5fn24OYcPrqAz9BJApJa9UHdJDdkxF9lqme02cKQbTjW/AlYssHV8Ff3ln9
 Bd7bMbLmos1v3VmTQ2zWz+aB7D0OgcSBbAdufTYBozMgkEIkYPmvE7e7Bj0kNc6YnDYv
 5mQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEU1jBOHrSnSiXaBd0Q7yHXAIp0ilJgO0Ww8csmOO0PIa2/0LUO2dxPfz6Mv80kap8Pp/y/Oc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJKcXHN5Ez/RX2i0HE67nAkmvHo4EJJdc4h14KhXjkFISvSDgZj
 SU90Sk650SI0teIHzfRQbvQKuGyBJeNqGTGAYewLJPmpBEphSzZDUmxlGPbGJniRl8AVZ952hTY
 TXSij
X-Gm-Gg: AYBFou3sehagkFbN66WV+hXBKOp3nTVfem4WPdRy6uEkBDBKDWuFtQFuatk87nbcrtB
 ZYXAJV/QmtacW9PMuMpdo+P0D7Iwlt+g7gm6J/xUnFiwRQMWWk46O//RQbtjjzSH9oz2pKgKLcR
 wFH0MMOESbYvA+X1KV1mzhZsB8Ttq3wE0HuKnvWaoDfUwxydDqjjeGBQBMlnD2kSnh2MSYoK2Pj
 ZDhE8PW4saIC8WLu6q+exakCFWYF/b6PeyyRRSUMECzrKWFfwup6ML/jnOv/Spu3llN8QOpAiwo
 Uu5A5I5GKoxrZu/IDCBGnEOs/bKZku/CTQheiJumgZQxjmV9u4EuDo7vto/pAP4jGNC7AR6tzT/
 MaNqbF+Oh7Oa5rKeK6nS3xlo9dbeNn5lZ9MonD32bOa7tlLnti67AgrPlNOsA4KRUWnVo8VL1UQ
 4fm5FBAj86nn/JporcUn0NI9WFSZ005h1JP5aj2coSszxAr2aiKAzoEU21Qr2IojAJauusOYYED
 4MLdn2Ix2rwa5v4MwTDXq+hUDuEuOY9GBrlfpu2Kilk+ab6zrPmS9DUgiJZ/7pMNYxJ8UpXW9ck
 405QtAjaCavrZ6TxtJGb+lCH46ORVWMnrOjXuUS7wE4M3iK2e8U9T8yGnK5nEYeXjQ/7r3xKssq
 eR4uUCDVYbi529veMmWPrAsYb2CJ3h8d7QRQn8SBoEtkKjno=
X-Received: by 2002:a05:600c:6214:b0:4a2:9cda:57cb with SMTP id
 5b1f17b1804b1-4ac151a9077mr60810425e9.1.1793370949426; 
 Fri, 30 Oct 2026 07:35:49 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf60f1114sm66573455e9.7.2026.10.30.07.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 07:35:48 -0700 (PDT)
Date: Fri, 30 Oct 2026 15:35:47 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>
Subject: Re: [PATCH v5 4/4] arm: mediatek: enable caches in the SPL download
 agent
Message-ID: <auSq5V1NPD-TJfFX@macbook.homenet.telecomitalia.it>
References: <20261022-ccaione-upstream-mt8390-da-v5-0-58982fe11312@baylibre.com>
 <20261022-ccaione-upstream-mt8390-da-v5-4-58982fe11312@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022-ccaione-upstream-mt8390-da-v5-4-58982fe11312@baylibre.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 11:26:18 +0100, Carlo Caione wrote:
> Genio SPL runs fastboot with the MMU and CPU caches disabled, making
> image downloads about twice as slow as with the U-Boot-proper agent.
> Enable caching to remove this provisioning bottleneck.
> 
> Keep the page tables clear of images loaded after fastboot continue,
> and clean up the CPU caches and MMU before handing off to the next stage.

Just to report that there is another ongoing effort to extend this to
SPL as well, see [0].

[0] https://lore.kernel.org/all/20261030-std-upstream-mt8188-spl-caches-v1-0-b45905cb19c1@beckhoff.com/
