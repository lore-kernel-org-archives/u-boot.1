Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2285FC982DA
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 11:44:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A60CF60D6A;
	Fri, 18 Sep 2026 11:44:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tXARkenRb_2R; Fri, 18 Sep 2026 11:44:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E991960D5B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789731888;
	b=V8NMcdulqnj96WjY569KSjXFXi8oEwuHjEnsgu2QrPlKtctalEinHNHHNmJJbrzRdJhQ
	 0Sw+LJ+HJw22THLKeOtl3+lQa57gSFDWmmeh/A5QZF9+xSw4ygcDu1WG0XfWx4EDFSobQ
	 QhJ6vUhCDpGJURDf/1ZzfyjYlSO80mspebyWptPWEHXX+XOJFvmGS069zdc65a52GyVD/
	 SNsZy/1U3K7lJeoR9lIqVOo2Q82Agxg49jovC35xI3rddgqoCElqlKO2QfHrKn/NzjbHE
	 xQ8q4hiEpygQCSg9YVXgF6ZMJXW/BnzMbRFTJgsF/CmBOuSj1c8Z0mnOCL6J8sCuzxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789731888;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U33bXqZRYr/HeyYuevCWEg5MhXNK7yH9P6+FQ+nMJM0=;
	b=O5UulAiJLU0uVrdKUF6ShV0euenjr1TpShUMLfZm4c22ofOitsb3FEWrv3PJzFAEEecd
	 bSJLqbTkWcYDodTVWBDgJ0obMBI7yIa4rr0Y31NzH30Kef5ywGpiKTIJjBFG3KjBFlVsT
	 27mv1qKP+9RyenK/OEwK8RW9pd4Kk6koTR0B98VQrIFxGG6E8YJVwCG1xNcbmdVbf3+oZ
	 4yaSRVfZ0Ewo9Tos1wQTne0/Lu0AU6jmq11SBsnr71r46JbNVxOSWeVV25G4JcZacw/Zw
	 0P50QLx7zR3Bzc48Yabw5h4RWwTmubq6eUAf9L4WL8bbB+nBWgfJxmzXbnPJwO7II+g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789731888;
	bh=U33bXqZRYr/HeyYuevCWEg5MhXNK7yH9P6+FQ+nMJM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cnw6sGS+q4/CvK6sx83iH7sxsU6bhDj9keILiI3W/m1LSECMTBGGgEvC/EM0nLEkO
	 RQAH0Z1ZurY0khkeYZ+X7xvbQNFd116fqXOJcWLTZbilrmlsqQAc0aRdKMf0w8ogHT
	 iv+Aamf3Au4b6Wljn/5etOGTOvnfysHCUSNE+glAw7uPYhAFocFfjnwifOxW1XyvNE
	 gq1DPfqhDBx/hzqZa176AmCwNxoKAxzrCZa8s7IFlXhUcOTKHWMh5axsLWPcPQBYuQ
	 Kj0Uj1eD4gegY2acRHHtpmI4yA4BuZfLwkVE+bNoSRO1XHWmfZs4ERX4p1o661IQx0
	 5Vy/5HkuOAckA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E991960D5B;
	Fri, 18 Sep 2026 11:44:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 687B123F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:44:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5A9CF40049
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:44:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Kht3EBQishd for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 11:44:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6825E40048
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789731884;
 b=dLwHeUVCRGGDLaUlBHqW416Vc1a0b0WybsznbpBAZwKoNRNDrIRElEgD+mtJvAtiPkrj
 I/34plIp7nfjxOuPG1HMMcBDMh68Tna7s9YJyZKNqswAQO7PjqKZvC2/5/UD1a4nJcEL8
 RS6OCOCw7v+eKpWHzOmApmenKsb9og/tggDBCoEFGcp6HCikb81jqOpzhMqkEUlY9l06j
 fwrvv18nJTfHdliyLdL9WsI9vfeOl5eNZDpmgbin0eFTyXZe3ocIHDH/b4C9LCBKkv+0v
 GH+A0wEJM1ft3jshz8+JFN4CrpsMw6myzQKGTHGLVFW1lAs1wsrgOea87tck1jDjFzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789731884;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=U33bXqZRYr/HeyYuevCWEg5MhXNK7yH9P6+FQ+nMJM0=;
 b=dw0mQgHpR0qPVS8BTxysKK6qsYHmHLzayXW9QOBquOjprbKNUsSRuCZqgbhWH0CLf4Fn
 yJsDO0QCURKuFdhTFdfVjPNOt6CWAd1VkIxezRDNPsb1eLHHCUZqT8UKJeKmF3/fwuYEG
 G+5ruepgzXfkWWBeS58hkm6mGKq9KShtCRDtBuJkczH3jWStchU23owOzwgGk1WiO1bi1
 UWDG5k0EfbzT8S03lMWb8Wxoj7AgEBiPw+JHpSOLdSwhf/HLz8nNoL4TuA0UW2LjsgiZv
 DUNGZzZu7E04cE/IHRNdWatwWl7OfztXQ9+Ts24xcrQaZzxsinlOqmAJl3QyonSENPA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=gWYcBUuG; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=gWYcBUuG
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6825E40048
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 11:44:43 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso3660875e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789731882; x=1790336682;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U33bXqZRYr/HeyYuevCWEg5MhXNK7yH9P6+FQ+nMJM0=;
 b=gWYcBUuGQrgh+s+g/uo6xp3jCuG8cSST/+SdIb/bGTtUtDvV2/2ycCnoZyp48Ap3b9
 MdlGMyGeDCpJkA60DDp8zVYQdGaKDMvbZ/+8p0iEvGjU6JgkffwWx+bALjCurgs3NTwL
 5S30WqUDxzOsCF7XOcQGQKo9R1XajFEn87yxp7h5WxXu0Elj+k+y49yHuvmN4OMzSjaC
 CyuXUrAeL0RSezB7HjjUfCQT6o8dxMabnv3JLbGuPNSTeIk7L22uNZ364SI6dtyEIT+3
 7OiJ/2/3zJWT1ugoKciSaX7dFkFPIqqoW/ul3fGpV8d5vuqmQOLH5Xtyz+FXxEmZ9nxi
 0PLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789731882; x=1790336682;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U33bXqZRYr/HeyYuevCWEg5MhXNK7yH9P6+FQ+nMJM0=;
 b=Nb4RxoFgJzsyHSx+peVm4tRwUpWSO4YxJ8n7iyBCSDvd4qNT48xTfRr17wjRVUiCtB
 4pHP5A5TbEHAdaGaHjfPZcLBk7x8K5bl2Xtu46Bh6BRwsSQ0ZnHg5B3rsxCegqm+SUOr
 h0pcdUCmquOWkgtOr4LngTBqcukxNk2aqlL0imY2mMH9OJH2Rx+E10TnrhpUxEl0YAuC
 o2JrQqFmc3FRykOB95DDQC2ZTeEEn+gjr24dsDxa9sjWZ5JjQyE5SYxnSwJ//GxsYirJ
 uqWcDHAllKNeWOX+p9vytO/mnvr3o+GToMP3ZZJNwNYT1nUEJy4ss5OxgLOzq4E3eBpI
 reFg==
X-Gm-Message-State: AFuF++lMEsLtUJJ7wD46XMtiq0Eft18VcgKzJLoJup8b5TBusk1OyIda
 uwVO76ueihgDRVFrE4OOaWFiuOQ79hDPjQkJaS+liZxbGadc3a3K8Y2j3O30suYyjWLa3sjuL+x
 zYB+C
X-Gm-Gg: AYBFou3r17ehkpZfcmvuCBpN7Pvu4JidKy3WJVWEGsDSeJ6eutpjFtRHz6c9zagkZvN
 N6qjrKWMULdEhTVzWMPajIVd3By/253d2uSZQqogBCFmxb6qyusgj6NiSaj1fWrlKUsZcoZx3FL
 FAwPGBfaSXZkzoSQtodpmXUgBtWSTN4A739bo77fWRas7/8MPEXC2GgOsRLCqssHJooNsat3b2Q
 Neopxi9LbLDmCj2DQMZuRdAjkQYg3WfNr+aKLHpO5A6Wp7++wCygMTODzYykBbsQzC3isI0zbQ8
 qcnKFA5dpXs3nNZbFIV9U4jlLD9cm+01b3hdzngtn/2Zr9pNvmBFHDvgvkNya050H0zjVTepsAj
 OMD+WuHSpFGeL/NS/7u3aLiSmp2gkX4SFK3eMrsMrTa2C/qWHDCeIvB2wVy9rK88eV9Skh+vtk0
 ilqJL6qcFdi/+dNuaUuGH3GgTUoohxUhlkhsv3W+a+d7I17K/9pDZ8s1fRMXufYUBUAjMue9EZ/
 kFaikPNRjk2GSHFNS4h7UARVjofWZVzuvl7PEE0faMPA1IgCJdG
X-Received: by 2002:a05:600c:4e46:b0:49e:642a:4f6f with SMTP id
 5b1f17b1804b1-49fc585e9edmr26713335e9.33.1789731882051; 
 Fri, 18 Sep 2026 04:44:42 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7d46399sm63549565e9.12.2026.09.18.04.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 04:44:41 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 15:44:35 +0400
Subject: [PATCH 2/2] rockchip: Declare unaligned access safe in the ARM64 SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-unaligned-decomp-v1-2-59909db61470@flipper.net>
References: <20260918-unaligned-decomp-v1-0-59909db61470@flipper.net>
In-Reply-To: <20260918-unaligned-decomp-v1-0-59909db61470@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Vincent Jardin <vjardin@free.fr>, 
 Cole Munz <Munzzyy1@proton.me>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335; i=alchark@flipper.net;
 h=from:subject:message-id; bh=UuCciDkPldbL1Zun+VyVrKuQm/vNQBUd8tA7J2u9M4k=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStVVG9+yhnWlbTo4qFPy0K/tVnzDBfZno2e/GCE4KGh
 bpfXoaFdExkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVJowM/4xK/8icYexM239B85ahsamkmEGCXMNCyS2zG88UBjrPvcvw30HotdS
 pDeu6P7VN1Kyr09lzzmnmdB23i1bFd7bOuSlxkQkA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

spl_board_init() enables the MMU from ARM64 SPL, and runs before
boot_from_devices() loads anything, so the decompressors can use
unaligned loads.

Select it under the same condition that code tests before enabling
caches, so the two cannot drift apart. SPL only: U-Boot proper is left
as it is.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 arch/arm/mach-rockchip/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1a2e7847c9e7..e3c9d57c4434 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -631,11 +631,16 @@ config ROCKCHIP_COMMON_BOARD
 config SPL_ROCKCHIP_COMMON_BOARD
 	bool "Rockchip SPL common board file"
 	depends on SPL
+	select SPL_SAFE_UNALIGNED_ACCESS if ARM64 && !SPL_SYS_DCACHE_OFF
 	help
 	  Rockchip SoCs have similar boot process, SPL is mainly in charge of
 	  load and boot Trust ATF/U-Boot firmware, and DRAM init if there is
 	  no TPL for the board.
 
+	  On ARM64 it enables the MMU from spl_board_init(), which runs before
+	  any image is loaded, hence the SPL_SAFE_UNALIGNED_ACCESS above under
+	  the same condition that code tests.
+
 config TPL_ROCKCHIP_COMMON_BOARD
 	bool "Rockchip TPL common board file"
 	depends on TPL

-- 
2.55.0

