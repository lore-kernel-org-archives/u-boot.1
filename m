Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BA4CD343B
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 14:35:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48CF1848FD;
	Wed,  6 May 2026 16:35:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="khshczpQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E00084951; Wed,  6 May 2026 16:35:57 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5798847E1
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 16:35:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so34583355e9.1
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 07:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778078153; x=1778682953; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7PWg38KhH/wCIs3O2SH9GQoot32i6xl/AhbcRJlbUps=;
 b=khshczpQYcD7ptaRKwnGOeicug17AVNi3ZZSrNSql5uCjltsH5ROE/O7edxB7W5qeV
 mBHBPPO7oLnX482U6Eb8+QNMsAmzjLZr5aiTSDbdfbCCh4sqOZnzpWDClYWE3PydzfgZ
 qIOve23nCaj7FFXjT3mt1yuhLEDeUobbe8vhdTsNJCGgetjZG6/iOmbvM22Tl8FoUr9j
 Et1pag9XDdGJwh781q2DNbK9omVtpzApFJBAciKoRl8NmsnOaMcX1xIOY0FYuMSl10m5
 DJAcnBeAWLw+GBvsD1ouFIWU75Mf+uFY770hlkfXVEYeXB7lZT3pHszbRa3mKhLE5ZgQ
 BEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778078153; x=1778682953;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7PWg38KhH/wCIs3O2SH9GQoot32i6xl/AhbcRJlbUps=;
 b=dG4+hDN+N8zmAWbfKbQbasVjC2MbVRkUxcHaHd6qzRmizos9ys7vb8OoCrPGSVDWty
 qf0xhm3LS4/JfWnkBGv02uFxPO7k6uIdV8oYtviijEdlKPuvcg4f9P9S65+OltIAp1Wt
 qLhRswgjB3Ltyyg+v8f3Tahol7c6XaHc6wcRNuEmiybw5Q7+SLVxbuQCmCGwZJ14h2Mc
 BMIBoPV6eOBGE/qfnTCAz1dJlQknTn+AIjVox1iblzN+WtRd5aiT/7f7J5rSLUROcKVX
 MJ0yKMOkSSmR9eb0pV5JewM0Bo+ZMdIpu6OdUsA3VVcgZfj458hQJu+6WsGWiMTmIjeh
 OkUA==
X-Gm-Message-State: AOJu0Yw8t9CyIk72rCNIrNIca/yW/Hp/QaWHie66BmLutX05NTBNkQZQ
 M/lh8xv/Fz8/G56FEnkTTopKEQWFs5u+/ECsJb5nwnPw/oXZoug5VEPN8/4FLg==
X-Gm-Gg: AeBDieuGfVUq/VPAdKENwzPwFJkjJJ6RAVuuEi2KJJQ+Sp7k+HkDlOlR2XCtmPPWoyK
 Ie7mLlHxE8fObofBmq7sm1ZqEa/M0MHj2iQ1TtkcUQnJEtf9fogHyICyivQ4eIxSGQnFpAyVaIo
 2kXYkVc4W1p7v016ZQufXaBrJST2ODPi6pQpN2lEhe+G89neZk1lAy8wXOO6bghIKS8TVO+FxQM
 uiGngWeFqqK/fSuUphdv82oF5YI8SxTWyNxmSzgohw5ajwbkIADXswoxNLLDe9NIffaEe32v6aE
 ZNaPyNp1llgX45fY753Mk356IWNiO+VD1fNSSyg3c21Q40hPKrf42hWaOxS/n/qHgospj8KcshP
 MbinrkBs4hEyK5vTHBIyl4p7khJyUad2Lo4CKvdeLKUrISDdxw3aOuRCcHjMclG57Uu4vdzMQUA
 qGcKonWzy+z2Hm/g6a+Wh9EnbJXIu6x5SLRwvoju6QPPQd
X-Received: by 2002:a05:600c:c082:b0:488:c40b:c8bf with SMTP id
 5b1f17b1804b1-48e51e0971dmr48904985e9.2.1778078153076; 
 Wed, 06 May 2026 07:35:53 -0700 (PDT)
Received: from [127.0.1.1] ([2001:9e8:9c:7110:7346:e23d:5001:3678])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53907e8asm50812925e9.13.2026.05.06.07.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 07:35:52 -0700 (PDT)
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
To: u-boot@lists.denx.de, Shiji Yang <yangshiji66@outlook.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <OS3PR01MB7802C722BA308D62F64EBD06BC272@OS3PR01MB7802.jpnprd01.prod.outlook.com>
References: <OS3PR01MB7802C722BA308D62F64EBD06BC272@OS3PR01MB7802.jpnprd01.prod.outlook.com>
Subject: Re: [PATCH] mips: mtmips: align MT7621 image blobs to 8-byte boundary
Message-Id: <177807813679.159113.2491465796758831791.b4-ty@b4>
Date: Wed, 06 May 2026 16:35:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=188;
 i=daniel.schwierzeck@gmail.com; h=from:subject:message-id;
 bh=R2P28DuCuzb7YWYyYsdpf5kWorxDonLhsl62miKSbIE=;
 b=owEBbQKS/ZANAwAKASj5Tpck8lwYAcsmYgBp+1HAlCYWQbib1x60fzw8fCAxy66mkofsVR5JC
 7fZsUZ2D7WJAjMEAAEKAB0WIQSJCQdQf4nTYssL0ico+U6XJPJcGAUCaftRwAAKCRAo+U6XJPJc
 GKy2EACvs43Y64mITF6Ei8XSTVy2pBd/eXpuvJv4TFS4Mbr5e7pUAKrEYLdalSx4j5pCA7jp48u
 lnoNijdUOJvAFxBYFK4q9qGjqFwa3z4KFjAzFQzKq5HAWZctl2IyuF41rv8+LGGUHYQ2Sudpe+4
 2DRbZ1Z8rC8i6m+x+IctZmTuWLGmt5orV05TVrP27NRWWjLF+ouuXe8nnYFozUsTw9QlFMoRLCl
 owBFHZgwogfx1brx7YmXeQUusAkYAboJJMAJ83rqUvJWdmpUqyoSNDU1tHMpuv3npnELqNGAXEe
 T/O6mqBMVSFshIaej8/yYgiJEbisgpMc6QIE3qB/5FbgpQDt6fj7yH9d5Yp106tOzQMP/93yZpf
 08slAuTI8f+VE+YLwecHCNvFwH1p1PM86h9dtvLRHC9k3DJOtv31LGsxUPihb6mQW5c88XxbRs5
 ojcGK8UQ9kcxi+ZSHP3TS6C5eAk+dVeZDd501SZbw2NuBde+rGqFZKXzgbAaaFqSpy4hb7uTsGm
 NmhSjF2CMXSMO4zAqye3DNMAupVSldAwtuooRc9lIuAPEj0ddqIlUhS58uncLPJeKa14EIbA0SB
 FPYrgi+w7OLbqWnpACJp47+gWq+0jih+e03ffhCACUWpNzL7tGWiODBihBn4HKYqc7nG+bbOpdy
 7MIEKRQCEAcc+lA==
X-Developer-Key: i=daniel.schwierzeck@gmail.com; a=openpgp;
 fpr=8C4E22B0E9754D7137265F81A90C48903C7DBE56
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

On Sun, 12 Apr 2026 20:12:25 +0800, Shiji Yang wrote:
> mips: mtmips: align MT7621 image blobs to 8-byte boundary

Applied to u-boot-mips/master, thanks!

--
Best regards,
Daniel 

