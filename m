Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5865C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 19:48:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69314403F0;
	Mon, 24 Aug 2026 19:48:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nhTEqykHFPrS; Mon, 24 Aug 2026 19:48:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787600904;
	bh=j0n3+qp4A0K4gQzqqrnTa39ywlO4oC+domTroddkOxo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=euRDCdVKzj+Ncb+m08mjqYIzUXa+1ItpWqfsOQ/kqi7XbRVgker/MPOTohOWd0ius
	 bpu7Z9AzWMVbpOTPWx+y5Ri1xk4AB9kaVG81UUUypsCUvVTuQi0LiFuKw55Mo29NET
	 ZeFFsaF45jPealRxubeXXFzXY/njetWQh8epd4nYblRnDdhmJiqvHzSrRAyJKZ2bzb
	 NXJXQ5CGdMbZzRboWqPi/RQ09XTULr6o6PAYjc+GAbf2y/3bOsdwHqFGcdsVQq+aMs
	 Jrfh8D7dyxWKHSQyFsAs+DNXrxGBL5BwXD9pK3e3JePkEuKeubXoqITGQ66OrJzxFz
	 0KJTBBtWBgsJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8124F403F1;
	Mon, 24 Aug 2026 19:48:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A66BE279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:48:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C82460618
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:48:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t55XRr0shgaG for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 19:48:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::;
 helo=mail-oi2-x00.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=X2O0kV9K
Received: from mail-oi2-x00.google.com (mail-oi2-x00.google.com
 [IPv6:2607:f8b0:4864:32::])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A3C2B60608
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 19:48:20 +0000 (UTC)
Received: by mail-oi2-x00.google.com with SMTP id
 5614622812f47-495d5d27acfso1855302b6e.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787600900; x=1788205700;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=j0n3+qp4A0K4gQzqqrnTa39ywlO4oC+domTroddkOxo=;
 b=X2O0kV9Kwxen/DzdcEyqIk7d2iNU5jK8I3LY9ZYDqhOp6ZpDBs8TUpBOvox01hhsBe
 2Wr/g9+kvLdIvSl21M105i3Qb1zmY3X6UTYwi/wP8Orl3WbGcUeYvzqGyJqc8zDJCXsw
 Cz3EgQIFFAbQkJz0wNCIXF+iZU29Ijq6qInZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787600900; x=1788205700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=j0n3+qp4A0K4gQzqqrnTa39ywlO4oC+domTroddkOxo=;
 b=MYcP71rDOknn70ONG5tgwEktaJGWF0tXslNTXOxk76G/TYy+rLfrdYPFRnKCax/P9L
 N5+m2A8sBKNl1yX0jm49bXWulPTibdfzsDb/Rn5CNWosu4Ztjzse5eI3+54f2n/WPiFU
 xnKXELbpS5kRwwY2IQ1oWJpNy/YPCkRGq5uXw2oqF+pkOv9YfNyNFbkZ9RBnoT6d1frb
 O8Mo42OuX2GdaJ10fovksVpRkofnQ3s0p6qNkwJkXwhTm7G4IxHiJz+Qz5Bbn+iReC4c
 egcOvOBHXdxu8ED/2MNisWjBNqJMrrIBOjCi4ne2jb1gCrwldPZ1yuGoRmkK1cQHfa/Y
 KhMQ==
X-Gm-Message-State: AFuF++mb2gWzLK+h0a56FU+u2NkNPTs+lgh34sUZjNliygWCwFkruxlc
 Ho2fDswTcwzs+j5s67CuCctqtmV7OPPSvz5EC66Txs1zqXRtXCzMB5v/i8NeEyv/XZUiNC0FYNQ
 eo46NLBTy2TuEltk=
X-Gm-Gg: AR+sD12kebYd9sAM3QCZyH8Q1ZGtvUErx4e7ZenCXHJKcHCOqSDZrW3Vxk6zqpmZrG3
 MKn/ElHQve/sVd4CwEg0yfquDNL8A10q2JiyGbsX5Q0+Kt1SSEnBpsg8XHJAEsWKhOJ+ZisvZT8
 zVXXlTbzyWXuXE98728ulT60LBr5TlkftuT2xYQkYAs+dPbsONBEvOKLI8pCIYFRuA2/Vt1Pz/X
 HVKH67i26oMgs5IESQ3HEnAyG85HpDGQTiWNNB9ATDEa9KN51IX5uMxyiOxyIUKZ5q7/gb24vIj
 Xcdf5BXUIAs0JaG3Pd0CsR2xXKKstSDW18aB63VpqlLWopRbzSml96GqhYS8dtTZEDGdpyFuw4A
 4BPVws+5O7e7z3ObGHvPB6QOGGQJkPFHDkD2namlF9tyJ2mZmlhknH/59ywFb+2fjcQziTAy/wP
 uvRbhFeEioT0OyysOcykes0B39SdX4l0wVITBaCCTfgI7orT59cdWSps87ouczdrN+Vk6At3KH0
 OZNw3ioyEYIuZ0u2/e++s/lZUZz7vft47q9xK8/9yBQykAKXnLDSn15E+0xkgNzpgjTMsSjDO6Z
 acrGl5EXuDtAgvlDMLvXEqEyp+zzKBqBCg==
X-Received: by 2002:a05:6808:1816:b0:4b2:8e51:8d56 with SMTP id
 5614622812f47-4b2ef1bd896mr26139235b6e.3.1787600899721; 
 Mon, 24 Aug 2026 12:48:19 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b32c6909b1sm4340077b6e.5.2026.08.24.12.48.18
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 12:48:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH v2 0/2] Correct behavior of BLOBLIST_PASSAGE_MANDATORY
Date: Mon, 24 Aug 2026 13:44:00 -0600
Message-ID: <20260824194814.555634-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708013019.288985-1-trini@konsulko.com>
References: <20260708013019.288985-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hey all,

This is v2 of
https://lore.kernel.org/u-boot/20260708013019.288985-1-trini@konsulko.com/
which I've also split in to two series, with the second depending on
this.

When we have mandatory passage enabled, we don't allow the fdt
address to still be overriden. This is mostly working today but there
are corner cases where it could still be overriden. Correct that by
enforcing that if we don't find the device tree in the bloblist (when
BLOBLIST_PASSAGE_MANDATORY is enabled) we error out. With that done, we
can rework how the vexpress64 and mandatory passage support works as it
wasn't using the correct symbols either for this case.

-- 
Tom

