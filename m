Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EF5606A331
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WIPEa5NR;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=YPgH32Vk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0E5880FAF;
	Mon, 16 Nov 2026 20:45:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cjy_QyxqAW0Y; Mon, 16 Nov 2026 20:45:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D3B5480DD6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794861934;
	b=TffQV3Jh3Bgea1ewhBcexzk/Mmk+yKvEcNKuOafTw/K7D0kJODAbKWZ95sebyB97jdmY
	 IasoZg4AL9GATLHM4/W5I/i4k+81paWry2PFAkzKYcdehEJKqrgmIzhrSEpBnVrgbQPnR
	 39tnQc1AlQrG4NOAPdNM4IxXsQDVfjRDAjddtK0bvfwv+9H001Aq9/A/CTaNt2mPYT9w5
	 wCNaqL3R7Pb2fxLh/OFIKKWPawr3C/ToSanSvhr22eYf8q9EHhVwSJV2Fg+DERwWYykfQ
	 EibIxXF7bkpatkDKxX7uxmyCtPuU+G7gDABAwSRTQd8Ni2/93oUAjcf4azgGaPLktpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794861934;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+swBVzT2YcRO6qS0UkSvcPd5hEvC82rVswgm62Xg/TY=;
	b=Kz9KwugK87KNCvZPyaLewfMSgSjP4pA5zrPpTqx1rFzETWVzu+6RQuE5XCWjO0+p6zJG
	 qPSv6Cvn9gS4tUa7idSEUTlw1jLlB2wHhfQCWMQeH7xhrLLTnR/yjK2xBeKqUcxrQFiVx
	 b8yzWGrxNFmWYhjndmU75CeSwRYwbV1aMT+vX6fJksyY07yztWc4dBQ7kZPz80adCLAXN
	 2yDak/PFWzh79GWVlBKEyJDLV+Nk/XHyNRQ8RA9l5Q1YEAAayYZHRJa7laAQXyUsorLYS
	 MCGypz+p+k0DToS4GDdN7pojQ2BorK9T7uKGq2PzURs6zyHihZQTGI+BSZRDHPrgd8g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794861934;
	bh=+swBVzT2YcRO6qS0UkSvcPd5hEvC82rVswgm62Xg/TY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WIPEa5NRy0grLL+mJn/PDqsFA163/HI5vsu3psA+QSqNedI0AJwyTZ6xVeoJDwM+p
	 SehroMkG3PvUzOUm3BvQi1uA75/V6FYw17QL3qvexTL4cN1UcXbJwexn/J1GVDAaDl
	 vxLZypMiT3Ph95uCXQ39OUFc0/v3u6AcWN5i5uwXPVezm02blhCjcxTI7EiXFPE6Fr
	 KkXXQS0AkNH2Mx/g01wDfOi7AoKl8zYYqgW+B1sPoD/ZdTpab0yTAQK6lUN2XydoG0
	 EFFHVZQi8CutTPot/2dCHu8Fdbn9LQQhRCMHEaiiYBZ3nr1O4YONtZHDU6yRTWb9Q3
	 7TNTwNy14Kpzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3B5480DD6;
	Mon, 16 Nov 2026 20:45:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 923CE28C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8686B40670
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FKwbj2npF43z for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:45:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6BA9C40644
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=YPgH32Vk
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6BA9C40644
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:45:31 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so41555215e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794861929; x=1795466729;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+swBVzT2YcRO6qS0UkSvcPd5hEvC82rVswgm62Xg/TY=;
 b=YPgH32Vk5ic3O+Wvx0ndXfxCrp5W1AKCrQDMm/JZhBlrIzZGw9tpkvEVIMcONej2uZ
 ZmI2eCFG/DToZ2G/kttkurNFdm9+7Gm/T+Y3rCKn9TaPwL4UsKCjR0FKyrXt4ljl2QRU
 pfDjMfdJQhiIJl3tmo8ETTZtd7zCmGX4v+QJaf1XG32afQPvPTkZ6HTW7ysRf2v1noy/
 eadFayjjmTvQjF3YMK3l5kvCOKOpPAXOtMjQxyrnCzFx4IWK57TCkpZ+ELgjpj4BbadM
 maYDZM57+RJ1/odVN61yYX5D6fwr7QFCvFmJwj/UdasRrJYNsvzQu2XGydtUK7jB6p6i
 Pq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794861929; x=1795466729;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+swBVzT2YcRO6qS0UkSvcPd5hEvC82rVswgm62Xg/TY=;
 b=b7UDF4vNJBdBGNUNt0PQzbom1j3kxyU9I1Yyo/eRMVON3KdaTBPkA1X5rGdxUOFOQ7
 l0TNW85Zq1Db9x2sbTyqEnrfrNINzCgp4bD8ljFm5qffjPrnGfSovtYjNOONnhR7Qb0J
 ta6IJeBFe3SMwgVhyX2VRcokCtTE9TwZR6B+nKCQ63LsMVjwzUa7i8+/LBCVJMZ2yTa7
 szASUzWD2PPW0YMW9WtHOQWY4dk8hDNCK/f78+H7n2Ts1UbdQ3BtpNzY/Z7haP+Fpopd
 xLtGwLeVvIutKdSaHD3XItgjw2ZwzaBtV83WxZX/oYA41vrfF2WEmKEskKGdZCD8t1Eo
 MU8A==
X-Forwarded-Encrypted: i=1;
 AL+hErEG/YLw3fTzjgYjMkKpD5uSaVoUKXJF2jtZpwnB0OhQBOvYfMWoUIZyHtKe4gSy0mhYtJBI7aM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/faXDmNruHigPqIucdcEC49KZVyc/gDaSr74qfUdvdBeeNrYEI
 dGtlt9Wam+NckBtE+Fmwe0snHz43DQMExTrjbo8SAVAbr+D4tR/8YiscppsVjDrvIzo=
X-Gm-Gg: AYBFou0gXvzfdh7pdP0v7DQf1VfWXpigkJqn0RF8On/GwPBi0+1o7c/pdVNjVRa0xlo
 D+Yqnp0AdJnCbPProHGXLCyc6cb8ikV70YtxvXMW0Qd6R34tWgsExedtqsRundq08uTUL+B2HZa
 ptVaBe+x1aQAdw0qrC8Kljc/TtYDMxC82BrOdny/6i/BETtlmdnhXkS/HSoZVvrJvwHNMb715pD
 BhnoqWNVsdxJKjxILcWuJJeit0+KIohakHzfvS8ZFxTMGyhExvZkDl2jcE1IFW3CFSEbE2O8LO5
 y25CBuk+zmy6Rzi+RkdBJGSKkduSi72F3yBPyfL2znbrxK9Nju4LOjR16TKJDjmgeVvO140SmOL
 v69Uij+s1dNYaYymObRZWFoPZj0V/0FGDVAtLsJX88FVhFrTZ0GdQon/3CpQUeN0RjG6e+PTkhO
 gEojJmIoD81uCv5s0/PSIqgGBPWUR+FdsZxKnxj+xsYPKSCTxnf5phlVs6bj7wK+1lmbp2dHgxi
 d3i9g/qWr9ETd3BMktsYfeXNjlNmqBELlWw9glJKUZUvSZtNXzg4Wq0GCtQsGG9GV9We3Bb0ZAR
 hh8rKiSlKFxtjquF/0A7T1l1aaRxwEln0W+v46V9TZIn0xPGhUqZr8wT5pDKUTyK3Lycd51UJaJ
 eSAtLXj3/rwDGc5LfD1e3V2MrnRIFfh7+rkYDRTs=
X-Received: by 2002:a05:600c:c4a2:b0:4bb:7581:2bb9 with SMTP id
 5b1f17b1804b1-4bb75812c05mr61196115e9.22.1794861929015; 
 Mon, 16 Nov 2026 12:45:29 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78386902sm16855545e9.1.2026.11.16.12.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:45:28 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v2 0/7] Enable UFS RPMB-backed OP-TEE secure storage on
 Genio 720
Date: Mon, 16 Nov 2026 21:45:03 +0100
Message-Id: <20261116-genio720-ufs-rpmb-minimal-v2-0-b64eefcfb0f6@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/42NQQ6DIBREr2JY9zeARJKueo/GBehXfyNgQE2N8
 e5Fe4HO7iUz83aWMBIm9ih2FnGlRMFnkLeCNYPxPQK1mZnkshI50KOnoCWHpUsQJ2fBkSdnRlA
 Cla7KSkmhWd5PETv6XN+v+sdpsW9s5vPwbAyU5hC3S76Ks/ePZxXAQXNhKtl2hpfqac02ko14b
 4Jj9XEcXxPu/EjXAAAA
X-Change-ID: 20261111-genio720-ufs-rpmb-minimal-41e476364217
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series enables UFS RPMB-backed OP-TEE secure storage on Genio 720.
The goal is to support pre-OS services such as EFI variable storage with
the same RPMB device identity used under Linux.

The platform also needs the OP-TEE UFS read fixes [1] and MT8391
platform and hardware-key support [2].

[1] https://github.com/OP-TEE/optee_os/pull/8238
[2] https://github.com/OP-TEE/optee_os/pull/8242

---
Changes in v2:
- Replace the extra defconfig with an optional UFS RPMB fragment that
  also enables EFI variable storage and the OP-TEE RPMB command.
- Enable the OP-TEE client in the common G520/G720 configuration and
  select the UFS device tree through DEVICE_TREE.
- Use generic UFS RPMB terminology in the configuration patch.
- Explain the failure cases addressed by the discovery-state patch.
- Add Ilias's Reviewed-by to the EFI variable documentation patch.
- Link to v1: https://patch.msgid.link/20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com

---
Carlo Caione (6):
      ufs: rpmb: validate requests before issuing commands
      ufs: rpmb: stop the model string at its NUL terminator
      tee: optee: keep UFS RPMB discovery state consistent
      tee: optee: enumerate UFS RPMB services when consumers exist
      configs: mediatek: add a UFS RPMB fragment
      doc: uefi: mention UFS RPMB for OP-TEE variable storage

Macpaul Lin (1):
      cmd: allow the OP-TEE RPMB command with UFS storage

 board/mediatek/MAINTAINERS         |  1 +
 board/mediatek/mtk-ufs-rpmb.config |  3 +++
 cmd/Kconfig                        |  4 ++--
 configs/mt8189.config              |  2 ++
 doc/develop/uefi/uefi.rst          |  5 +++--
 drivers/tee/optee/core.c           |  8 +++++++-
 drivers/tee/optee/optee_private.h  |  9 ++++++++-
 drivers/tee/optee/rpmb_ufs.c       | 18 ++++++++++++++++--
 drivers/ufs/ufs-rpmb.c             | 22 +++++++++++++++-------
 9 files changed, 57 insertions(+), 15 deletions(-)
---
base-commit: 934995f642a21ca7f35fa9aed5f061394fcba243
change-id: 20261111-genio720-ufs-rpmb-minimal-41e476364217

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

