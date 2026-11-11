Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5D8606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NwY7gXBe;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=eKsUI5zR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4594B40932;
	Wed, 11 Nov 2026 10:21:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q16sx7s_k-yA; Wed, 11 Nov 2026 10:21:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 24E4640871
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794392510;
	b=f6KWEqaN3CAr/qWncqFSmSk8u1ZAjAq19PXoGTUBWNTNUd2mOWCWiWG5oRYHxQ7m5RJ7
	 iypyziL0EVfUTi8eCmh7irTyyGofH9dtDAOXVHU25wjDaa82ef7SA0x3sMaI+UUsarRub
	 ZZIDV+Fx2P0RwAhFdmycjqGj960O2AfhgiZRUvhEkDUe5007CShC5vALp04+S7VqU8BTO
	 tnd8IBb8CFqwkXF+Rliy2TRxP/pD/xZU71/7/y4J3RwyXnX+LS+4Gks/GgKwczlsc4K8s
	 RUdSgJWz5zejNiA3+Z+iEwDX215Wbv+TQpTY+sQNP1wYcjoufgHBsX9w0Rq16E1rLjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794392510;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=QZEy4KFbVWB6k7hGR/D+DMPS6pR/kpy/V1mlqEvk7QU=;
	b=ozjGtrDUIVgGILpuXrg7baSNF2NzKC7Gqt2uywGlDNhwKfxSaIs7xYgzINJ9v6V7dWBT
	 QlpshiKkuNGL26fXYNrFfuOgLTjoIBiaECZPypFI3IsuX2ESpes8VlzmdXvC0fqI2N3t/
	 bBhpIkoUV+QA7Ly7n1TLqXQsrEmBFKGBhXTfk+DfrWPKgyMXbmJINH1kEzRhx7Isb07Jw
	 1vnDM4aQv+Kz7D4qbg/gj4kcqWzNZZ0ckwfrXgtMaM0ed78A1epo50VG9Ga4HUxBRYFZo
	 7X3lAR/isHwqyR1uR0q2XHagZ4GsP68Z9U9kEFVbqLPmGt3gWlK5FN60KLTTTDPZ6Kw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794392510;
	bh=QZEy4KFbVWB6k7hGR/D+DMPS6pR/kpy/V1mlqEvk7QU=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NwY7gXBeu2pRezlXRsDhxL+VzI14UJL0vExOHYBCE0uTug06F3mCCLOc5f+qJKZX4
	 /hMeM1Uy35VVAzXBX2MEKFHSJha+UoCr7ztHdxOo7HjIkl94+J95QPlDHHYyfW4Zpe
	 PkhUm8uuLr+ZnK2sqTnZy94pfUwfMxxcHEkkkPmLZD98/DOuzGdq5keaBtKORbolaz
	 jRt2ilWx8PKAG88IpljZGlLYOndFZkmSAKk8m0FkcQZqFwsoHI2azQlTcCRvsagqGq
	 WZMI+nnvPZdXmxS5YFk4MXv4RKrdybFgWgg63tEcCwSM94BVbmJBCM9GR2HCcYZBiz
	 ECB5iuCqKIH8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24E4640871;
	Wed, 11 Nov 2026 10:21:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 656591A6
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 49F5D6069A
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S0wZbSpSqRlL for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:21:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 71D2160784
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=eKsUI5zR
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 71D2160784
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:21:45 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so2219577f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 02:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794392503; x=1794997303;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QZEy4KFbVWB6k7hGR/D+DMPS6pR/kpy/V1mlqEvk7QU=;
 b=eKsUI5zRytcCHtmxkcanW/rfDWfMtySJE2TRxBOl+2Neo11AVQwfcUrX6sq3Gupv9P
 CHDIm7aSMPjkn6RxceVDXzLJISa8INEcMigjpRa0ehtpWozdtLb5GqvvGw5vEW/+WIV2
 mRM4p4NDDA6Ei+hF+6ZU3e2+GZ/t9D/2PbBBhw17QQwGizVvxuBdJ8ehJCB4N0dxYo8F
 vUuTy1NZFwFi0zV1yV7yBN5mazK4F70g3Q5K6LReILcyg6t+2NYTPnPZmG0yQciTFaI3
 UbASznVVTFdOVvB4hef3lGErHWhnBVP36DhzzUJJM34TSCcRX9BAiP/SLO2hojegqEA0
 D/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794392503; x=1794997303;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QZEy4KFbVWB6k7hGR/D+DMPS6pR/kpy/V1mlqEvk7QU=;
 b=Uw1b4pj51og4mYHCeP6wj76vAb9YPGTlRzukLHlLwXLKsR1Gmr9Xp7r3HZzr8uVAhk
 4FoJTdobGYjVfKHKvKq/L2EoAiGjBhNhEI6BBq4BFy7tJnI+WcE+GqYA1IB55yBE4Kb1
 MXu/CyRHMhvSfBI8OWLBrddnIyj3CTgiDTlaaw2sEIvWc9DJjLm72ofwKW8e4tJzXyQr
 nFt5FxZrpoYEFMr/sTUMKLBw7mlavtC97fsRD5/QDy4aGQsHLydHahhGqSApTOboNJAJ
 gWPquQH2ZaJMQdeOvnl003PbLwj9q9e9qUi2/2j0S6FTAUXmKF2MN4QUEBZ8kmYYwtg8
 KESQ==
X-Gm-Message-State: APuU4Z9VxlItiJHsnQfckSx2OnY6nz0UsGct0QMkgEUBZHwMQ+Wiw1EG
 LMzSrngFOZlho0gbKhj7nkAH7LmhkkVp76uhjHuVumzGYIVQ8WGC2aic8aEt6AzrAf0=
X-Gm-Gg: AYBFou0IChbrVkVMZcFmsIKnkNqUNZsIFtS64A3+tBUN1RtD7yRe90myE/9VxvTO2Ey
 5m9KTJAND7ugCvrx3tBVWWNZDkok79q1em8BZtao/QwZVfAh9BU8IxdYOXMfQiYiOPdQtnejQ75
 oCKTWTxBuCipkqeTpVXTONFiIBLYqnVPs823CTn9PJR8GXbqiOIOpySJqqbIbEt6NCuuoxv3h55
 HsRQqAoJqBVbT2NsDRK2gV3yF3b5qasjJABIsIDb1McP6rS/r4jcolHSA0QGp7CPYtKVEBLwVqh
 wN02I9A8Wkfjm+6SaNBCB+pgNlgQAYG+20b+a6HI2EYFFqoE0PcwOsNY7jJa7bY4LKjjWloFfkN
 JTz+vTe+9Wu8uBOm2dnVPETwrnzALQawxFakm6+PiZJQbKOiponPzUHGzL7623TE8MjZrQHKN3z
 ZOWkt++9QeRUvgxQ0yzWnQKvTVL6ZHTrIC527cgUdYAMr1Jd3LqYbyDv0S2hvaTHFHPYOFWwQlc
 nkkcTMhbCBispbOOV+qMkqqfuYhti7wW5G9J2QUilDSDEGWM7XP/IXcsyGqZkOdVTRnJljoYvnU
 k/3PxGNfdbS2NCt2LhFz2kh8M7LcJDplu6xXzOIMmdwdSF/DgiCJc9hnDPMW9UIB2zehsj3oQ5D
 Z6OHgcTiPg3tQh/MDAXk1DeWMV7/w+aNsHanVVtGkwAtjgA==
X-Received: by 2002:a05:6000:387:b0:492:7fa6:efd4 with SMTP id
 ffacd0b85a97d-499c89825c7mr3272264f8f.9.1794392503310; 
 Wed, 11 Nov 2026 02:21:43 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835858f26sm10550001f8f.18.2026.11.11.02.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:21:42 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH 0/7] Enable UFS RPMB-backed OP-TEE secure storage on Genio 720
Date: Wed, 11 Nov 2026 11:21:33 +0100
Message-Id: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqEMAyF4atI1gZsLS14FXGhTtSIrdKMgyDef
 aq+3bd4/wlCkUmgyk6I9GPhNSSoPIN+asNIyJ9k0IW2Kg1HCrw6XeA+CMbNd+g5sG8XNIqMs6U
 1WjlI/y3SwMfTrpvXsncz9d87CNf1B6NB3i19AAAA
X-Change-ID: 20261111-genio720-ufs-rpmb-minimal-41e476364217
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jens Wiklander <jenswi@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
Carlo Caione (6):
      ufs: rpmb: validate requests before issuing commands
      ufs: rpmb: stop the model string at its NUL terminator
      tee: optee: keep UFS RPMB discovery state consistent
      tee: optee: enumerate UFS RPMB services when consumers exist
      configs: add a Genio 720 UFS configuration with OP-TEE RPMB
      doc: uefi: mention UFS RPMB for OP-TEE variable storage

Macpaul Lin (1):
      cmd: allow the OP-TEE RPMB command with UFS storage

 cmd/Kconfig                                |  4 ++--
 configs/mt8391_genio_720_evk_ufs_defconfig |  7 +++++++
 doc/develop/uefi/uefi.rst                  |  5 +++--
 drivers/tee/optee/core.c                   |  8 +++++++-
 drivers/tee/optee/optee_private.h          |  9 ++++++++-
 drivers/tee/optee/rpmb_ufs.c               | 18 ++++++++++++++++--
 drivers/ufs/ufs-rpmb.c                     | 22 +++++++++++++++-------
 7 files changed, 58 insertions(+), 15 deletions(-)
---
base-commit: 934995f642a21ca7f35fa9aed5f061394fcba243
change-id: 20261111-genio720-ufs-rpmb-minimal-41e476364217

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

