Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CEE606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 20:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Nd8lj/hN;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pyBFdnZR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1A824095C;
	Thu, 22 Oct 2026 20:59:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tn5ejiF-uIvV; Thu, 22 Oct 2026 20:59:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 02FC94091C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792702764;
	b=nKGd1pu5kEYk3VEpg/lHuyAuPVJkzW555Furm6o8skXCd2WoWruwC9FScsU8tzBQ+lUE
	 IM5rHHjHJ1P3LRR5nwAVEJN42o3oks+EO9BwGbFRfTvvvaD2/qbuTckhURACly6EoNlyH
	 OFGCAOop1gFDrKVn5cwrt9Ps/DuNzGgHJ2A5m9oelt9R7H+E2s73ZKd4JitJkPvDgcDcz
	 oFZ+iJBvgutIUnSh4UtjQ2HZO1zne91IHgePOkrhGshtuTbcTd3qwQswzs/KqLFdiHqpU
	 q8YHTG+QLyHCdViqayHrbW5APX6AyJCh/ZgA7BJ1oFbiCpesPGFLIhEarI9SSkgJVvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792702764;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5N2bqVIvmMaUSjT/pFuggKLCXj3dp2y/QAlqih+SMyk=;
	b=avtg088DH40BMbBDz1akjpkw9FoKJqj1lYDrljzXJDxvvcIqfo8m+t4CJEzvYFeWV0Mh
	 dJpkPwiO0HWm16cdzwz0z28TuouvlcE5ZJmIRohtS62rPO5hn5yw+78MOTLPpJ6U3AhPN
	 h1UDn7CjMgnKt24O4G98jBmUYOpZCI7px9MH+GVSVXVAMAtB18MqyGwJcgiesldc2GheZ
	 sGom4origpdoa7mfhhkPLS7Ses18/vmOVTnzUCoH7GyqKprNe+W3fTi2bfDaOhLVK8qUI
	 EAMsLr4qT3sNMG5v7fe2gdYlHQxcHofIgKDjlNW607zrU3112eHEJDFZXLAcrK+zgsQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792702764;
	bh=5N2bqVIvmMaUSjT/pFuggKLCXj3dp2y/QAlqih+SMyk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nd8lj/hNcbrLHpBQCMRSZMh+H6cAFXthP1+aCWM11EkG9gsvOX7kIXvmX7ROxmqoa
	 t2PTUv6PIkNWwCp9jzl+KYnliNRktXdLUyYRj++u7+Eu1GWtoqo+MvNMj1yCHGUWPK
	 dz4vu4zGBRTTseFzOQjGt7LiX+anFyQFalLoXJYeeAcqNc/8jqJWSxZPh/IlP2uDRG
	 AE1Ju8HXGluTGvZJOtBZhQvW0kRGJHKzgZLDzKPr8ktVGYjyr4yh8sJX400RCHwf+s
	 nmt0n80Q8vASinvEUrEFuKhTvlfTvvRcghOFshJons6QSlWxAtL+VEQgZA15wuZzmz
	 ESlAR75YYl17Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02FC94091C;
	Thu, 22 Oct 2026 20:59:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AEE0D3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 20:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A0404812BB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 20:59:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZjheXtv5wJ57 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 20:59:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 79A2F8120B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792702761;
 b=JJVZ6v8n2FjZjyI69kRmu1KotAyMfncQD8DK4iGwj0gb0PnRCBaTbEHkI4KYfA2dw3oL
 S1ypouvHgE0MvInbXFKoWbwTEyA/DpuZ111WXPubW55DQjWBO7EaHr01T/UR6E75E/saM
 x09olAddBpYiP5WrsUBubtYPMHaalM7N33UKAssgYobUeWE4OZm9v0UAugvy2wIEvLEE2
 PCCUNBEpuYTBmB27DxbGTbFIODGyydrFL95lNcvj1zXzs7szmRj4ZjtF52GAB28tKLaf6
 8I4HN/EDGBVIszOaOiZfKM5i4DJ43jn12LzVFGwOUdEgkS2Svh2//eYaaMPgWlj+zHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792702761;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=5N2bqVIvmMaUSjT/pFuggKLCXj3dp2y/QAlqih+SMyk=;
 b=NOXdGPEKR+Ka54KQ4/eQ3MNpzdyQxe1/OS6cQwdaWOKO4TIdRB7ue5z8QBIndTl+mYfd
 rM1ZsLnnftasdXdZLW6ADjWnmxflTrAO/u2fHC4R8tXwqa3xZeNLAWoHqPdMgqdCMJ0Tn
 xQcKZ7m/97pmisfid6d7eOPnGmnP29mUhUtp+/AcrCIBTXD67yxYrRTKGr5nshde86KY0
 Vtx11xBLYywi3BT7jo2DeY2VMU5hJ75lRb3dV0ZgX+0ocaH2pbU+i900jhpdO2cROA6nd
 d+1iN4UpNC49pYJDro562Zx5/LfkEBlmg58wlaqfscGV8CZ5yUrxT1MxHDv2yF5bdPw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=pyBFdnZR; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pyBFdnZR
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 79A2F8120B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 20:59:19 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6faddda49e7so193106eaf.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792702759; x=1793307559;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5N2bqVIvmMaUSjT/pFuggKLCXj3dp2y/QAlqih+SMyk=;
 b=pyBFdnZRvLsmvLoWn6h8cpgvQrZeWJcKAoRLhuxWsLMv6vvmhvjjgpq99uaDBhPeIE
 4HJMfDb2uyc+1LNpdauzA4uiHhWU772uN9HaAcepOmZMzdTP5Yij6L54G69H2mDOKxfn
 EmlIvrMPOdsOUJpoJpD1qXqLws+tQnM2J6FOWhSbnjgv5GBir4CUnzsaMNEZV42pIEbO
 A28roFxxD3nqynYkVfT8FRNWpmT7BkckTUmHc6sia0DJjKTOpCBVJhm9bj/IKd/bvc38
 fAdQuvrD8FUOjE8+xYdBYhnkUaCkhJTpsKZ84ZV20J5Nn7FgQCigenH6/HwLbwhOcSFa
 CEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792702759; x=1793307559;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5N2bqVIvmMaUSjT/pFuggKLCXj3dp2y/QAlqih+SMyk=;
 b=NkvvNwg54hotgFjwG2SHJ5nYvwt02PlOHbkmZC+FHtRVhS4teE1rSSJvDjxxhAAQFA
 5bAfKyEaFvMmznrVUNHS96LXO2yPnvP3xtdwK9B/91EM6eSCOB40Rs0jL1iuPnrlrN9i
 ytyNplFEZNTwQJk7NSm0P+jg/58ivrJxcWKubpfKV07KxoQFAH3ncPJW6O8aQDD8CC8Y
 1yfjtaOnq4I/Tb/abWY0waqre3ZPpFS/0wb4hxxPuIV4JkIn0Lwe7zkv4Q3UHbR9m63j
 NHJzHo5sM5GWNE2t+DRQU4wahiRbjmrXdo7VzOglii0vz1kqpR7D3aQsA+53dX6jVQGi
 DcSQ==
X-Gm-Message-State: AFq9FYIFfprxCjT2gFNZiuzkdfb3YdOJl+bngn7lyDqLUbyDjVVg4KoL
 nK8b0DVnmvPMLjlC8Oe2DubTyA7mHhPfeFNMHyaOd6InEB1OwWJhg/65PNO9ho5aFlU=
X-Gm-Gg: AYBFou1vC2hRblk1X2R0AdIG79hAlOO5y3eT0iCiKDyOMrg6FJH1m9qHSYGQQTXmgCD
 i22KtQWPv8UWHy29awu/qgJPxy6N9rnvtuW1uJqJy2W8wG7L01rFvFWl5uwO7D+ugTtxceZWrTz
 7pejq7J05+FdHqU05du0qchtf7KlrbfT7+wTVRxLSqsDENoidRdNl+oY4W5O43l+kIUAyUWaUl4
 Xr4cpKgiei94cKXlIGo/jR2rLfRRyil7fWE/dNO/MPiC+K1qaVj8Pnrxyfo1nbOuPje1RoKrBTH
 bhaQAO/fnhjjWnZOVOTI2mEE199V8lXzNwYBWFS0c5vjzCly1mZW83vbX0yrnKxLH3uHE4qz+Aq
 rroI7e1kR8vX6ptZUxVpFIblymw05ehc/lVDaXcsLxj+8/bkmvY/yoxq5YsnQE9gsJIrZhYlNvL
 vUPKRSd7/caNH15E5YBK+tpsUPvfOD4A40lor8WTVKCpXc9osxlPlFqdSNSBSQug98AU29MrNs9
 f3nYsG21W5yZIlj4kwA2tmimduiHsizJAtey2u7j97JeWTEYEEmmfZfO9Lo
X-Received: by 2002:a05:6820:1354:b0:6f5:1e7f:c65c with SMTP id
 006d021491bc7-70b889c7720mr475374eaf.33.1792702758838; 
 Thu, 22 Oct 2026 13:59:18 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d0bd:a587:44ef:f6bb])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b8b283a76sm215732eaf.8.2026.10.22.13.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 13:59:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Siu Ming Tong <smtong@axiado.com>
In-Reply-To: <20260929-mt8365-add-phy-mtk-mipi-dsi-driver-v2-0-7a1bd29d0e6d@baylibre.com>
References: <20260929-mt8365-add-phy-mtk-mipi-dsi-driver-v2-0-7a1bd29d0e6d@baylibre.com>
Subject: Re: [PATCH v2 0/3] phy: mediatek: add MIPI DSI PHY driver
Message-Id: <179270269363.3711947.15493866080764019977.b4-ty@b4>
Date: Thu, 22 Oct 2026 15:58:13 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=0vOgKsBwv9G0Z43DgpBmHazewuLjmObcrkDD0vcDmLw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq2nkc4+EXlvh4BLmWCkfD6MaNImyHATTZdjflm
 dMOXWbhvmiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatp5HBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AaQQIAJKjLZ7nyWTe0a6Pq+ZdOiW719Qb+XZH5lbM88p
 T35iqUxx2/Jcy6RjPbIGXRxA7b286kLQgjQPTOLpOMJ2X9HG7LVy9jMJTbbERrtYcNWt4uPOJ4K
 D7nTxU9xGnjckcHO8ADkYqw+Mk6ojU8sTvlXZv+inYW9qvfQVqsPkteroicQdZlkHbp8pPOKPPd
 xI4tqE72BcH0z0+qac1kGyZWLSXjnYhyjhkMNu4559VuAn2afgfmAbnj+56mjNU/1M6aETW/Ji5
 1m5Xzp2Og2D5/UxHAwkIZ2Rv3TfSR5R6jLhhepmqYElF6/sWCW1TAsfT7o3h1fvc+OQUA8NjS6N
 gbas=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 29 Sep 2026 10:52:40 +0200, Julien Stephan wrote:
> phy: mediatek: add MIPI DSI PHY driver
> 
> This series adds a mipi-dsi PHY driver MR8183 compatible SoC such as the
> Genio-350 EVK.  The driver is ported from the kernel driver.
> 
> Patches 1 and 2 are preparatory patches: drivers/phy/ already carries 4
> MediaTek PHY drivers and this series adds another one, so collect them
> under drivers/phy/mediatek/ like the other vendors do. Kconfig symbol
> names are unchanged, so no defconfig is affected. Also sort entries in
> Makefiles and Kconfig.
> 
> [...]

Applied to mediatek-for-main, thanks!

Fixed some merge conflicts and typos while applying and moved clk enable/disable
to match upstream Linux.

[1/3] phy: sort vendor subdirectory lists alphabetically
      commit: 684e1372ed296023812c29fc8ef1b0029f851558
[2/3] phy: mediatek: move MediaTek PHY drivers to their own subdirectory
      commit: f1704411c22b275e3c63d015f84319581854431e
[3/3] phy: phy-mtk-mipi-dsi: add new driver
      commit: b87877633333caf7874ed9e41f723c2379663369

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

