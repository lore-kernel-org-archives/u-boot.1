Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7323FCC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38B3660857;
	Wed, 14 Oct 2026 14:17:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pKW71OQxomE5; Wed, 14 Oct 2026 14:17:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6F4DF6083A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791987469;
	b=CPYaD7j8AjVe+B9cOSvqjbYdMtdm4ttMpR5qS0sFE2P3+UgA5kdT12wHw7fHnirjMjem
	 sxk9gFKV0NMHUe5Txt9tmkPf1FQuGOV/aqHq6dExhN7kf9UfAdyNH3bt4y2zmyFecIA1t
	 LgoZ196zMOqWODFxYHGMceFUkpBoWqdDWBIVszEkQwYBF9a5EBghB821o1idlq5r27Dx6
	 pLpzMe51k4XDdOrKlerSM8vK9jRR5OWZs9RJVH5t/Mp4xMiE4vtAGNLMoi5zXEBy4gxsA
	 HAGUaEPlty8TfZUfgyQ07lfUv4UPKjNi3CTqOp/QArW9rOs+v1RJVXFiDi7FYW8hHWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791987469;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OxfbQk3mnTzaAJzGOeJCxtqCBU7uIEUqngbHRhQj12c=;
	b=WPhZxkhxXFEYOHXO3uOXJyLaEowZWUPBodb0Dh9acwJ1sE2fzHjoIWvRIzC8ZUEXat8F
	 457XEDiMseZquj3/Od/jrAGmZKIGM1H3N3Nwz7NIeYgL+f2NzyMNArYAqPTUxcvI9Astp
	 SimwioFte7w0mbeXS7qvto/+Fw7sdEnajod5EzQz4OJGmbrrEeGtF3Xpi0kzjxtDYV6w4
	 f2jrIZRb6JzaIZdMuzPhnTZu/tAvq+vRONKJzsRG8iqNxmC4gbbnWhbWLs2KZO0rW45B4
	 vWKIozsFd73z/fYHIt7yFUXzhZz03eprwEU1tT9zaXnTMovk8lE7qwMR2QL8Y5tPgQA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791987469;
	bh=OxfbQk3mnTzaAJzGOeJCxtqCBU7uIEUqngbHRhQj12c=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xDmVpxhT7MyEgklnGYtNJtkYwq+aZY0NtaAZT0vsC5yI0lWPAjb4endbuzPGW1mk7
	 pitVgsnMbLLnCALVDfXE748RB0jbVsl9BcOWnceULvFbkDQ9wny5WE0lRjqF5gGeKj
	 Dc/ZJzkpqY1tQ/1MUdHcIdk6lUTD/N1nAqcWsSIUAhwuByO9FDNnhegpBsfqwnDNF5
	 zN5o6OQzjBh11mgXRrbkaWAe8okwgpYwxx1XM2MeEVG8JCXwhSb7DvKdwa8bRdDgRY
	 3FxtMAAjtfVrZRFLohy98jCqLv/BnYDL4MqAXQxGVOxZ35tOyxxmn3KAg8eoX4VUVQ
	 TolFnuOdjep+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F4DF6083A;
	Wed, 14 Oct 2026 14:17:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BD0CD2E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A2DF080E15
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KmwU6v5FO6-J for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:17:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4C8F880E2B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791987464;
 b=MMKqQgSpDtknjz7yJRvXaRv3oSkzKbrAtCBAc5rsxbJbQTXYVfvLxtPKZrYnfX0Nm86a
 qMOK+TkS3sl1gLPgFYEGOP+N+BkwSGLqivi8KJgdgfznapLyQsIL/b03KMgo+IjpgTP7v
 qruTXz7R7DeVkb8gx3n5RUuWOhWHOWMPqJeDWKKYKVrg6IP2nsN4N6bSjEJGo4emG0Wje
 /hn8rAtXXfTHhMBIUJDYdE6Wx/MZnIS6LpOjjS0pD/9Fg5s0oDNculEyero76Tm8I0KT9
 hQ1aK7rQkb9m0icigqpzp0C0P0NsoNRgWBQlgNt/pJyb/CYo5t7zy1ZOw/tsKJ+hziA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791987464;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
 bh=OxfbQk3mnTzaAJzGOeJCxtqCBU7uIEUqngbHRhQj12c=;
 b=A1+ZOa+i5hQgJEvzZFdDOxqPrzUWJ6Tq517D2gq+VtqI4NynwYpF6KPBQzaOhJ7q5fea
 afgaYgspnp66S/keTX4edXZQrmDz5jGX5neJ1+wNyrzqMRv/BCpGdZRUf6Cf7MXr52myF
 1VvvjnAEgmVtLZei2Y5l08LyAckzPWzmeKqVwKEE4/akCVWViOSqCXpZWOghDilZ9ETeA
 XojW/3eUI+fs+8OvAPmnXG1qAphKqY689BuH6S6omoK3YHLm5D1NzCdkAYvwvlAXpVfLR
 dGJmflaLpy1/SlmMt49wSxt+/SOEQllnI60vh93XpPxdzxeVt4AHRsdmlQ8NvEejgHg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=microchip.com;
 dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256
 header.s=mchp header.b=RibRfnCQ; 
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7405916af=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=RibRfnCQ
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C8F880E2B
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1791987464; x=1823523464;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=f47peMV0RdD1dXh7PRX5zb5DUBtsJd6nodsgc40JvmY=;
 b=RibRfnCQo5SG009B0TpyDo+QDwmNUJM9OMOERXvwecp4Ub+F0+r+c1Xv
 8xwhWjuON/m8ZQJWxeoFgd7GLNx9d/ezLNo4LvlX8yWfyJ4RMbjVEqSum
 A0ksfow3wOYRfaeF0iYcbpbCZPirLMQ2Np/7T6ObcyOptbMGzl4yIJFdQ
 oOZ158hKI168MjSjRyQA98hVb4wrwvrAm2YFCTtiqreJOP05Q7sBwK4TG
 313anV2wIPEKF9/PhMk+1msRay6ZG4QgJw+rISxvKd3lgTsuVVaOUvMW1
 OfHrO3txLbw5U/X9QS0MZumxJC8thGuF4Vzt2PwEvsADXGWsH7sWoWvSE g==;
X-CSE-ConnectionGUID: PGKjxXNMTuGZSZ2nHS0Khg==
X-CSE-MsgGUID: ZTLCRarFQ4GX2jx0zlBYCA==
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; d="scan'208";a="75405375"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 07:17:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 14 Oct 2026 07:17:42 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 14 Oct 2026 07:17:40 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Wed, 14 Oct 2026 10:17:11 -0400
Subject: [PATCH v4 7/8] configs: qemu-riscv[32|64]_smode_defconfig: add
 RPMI configs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261014-rpmi_v4-v4-7-d53d34a49780@microchip.com>
References: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
In-Reply-To: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
To: <u-boot@lists.u-boot-project.org>, Yao Zi <me@ziyao.cc>
CC: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Romain Caritey
 <romain.caritey@microchip.com>, Mame Maria Mbaye
 <MameMaria.Mbaye@microchip.com>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, Michal Simek
 <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>, Yao Zi
 <me@ziyao.cc>, Peng Fan <peng.fan@oss.nxp.com>, Subrahmanya Lingappa
 <subrahmanya.lingappa@oss.qualcomm.com>, Charles Perry
 <charles.perry@microchip.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Add the RPMI SBI MPXY transport, the associated "mpxy" command line utility
and the RPMI clock driver to QEMU S-Mode defconfig for 32 and 64 bits.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
Changes in v4:
 - Add this patch
---
 configs/qemu-riscv32_smode_defconfig | 4 ++++
 configs/qemu-riscv64_smode_defconfig | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/configs/qemu-riscv32_smode_defconfig b/configs/qemu-riscv32_smode_defconfig
index 69f25349dc5b..afb7e086f7a9 100644
--- a/configs/qemu-riscv32_smode_defconfig
+++ b/configs/qemu-riscv32_smode_defconfig
@@ -17,6 +17,10 @@ CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_SPAWN=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_CLK_RPMI=y
+CONFIG_RPMI_FIRMWARE=y
+CONFIG_RPMI_SBI_MPXY=y
+CONFIG_CMD_MPXY=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2
diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-riscv64_smode_defconfig
index 084960460c93..d03f716484d0 100644
--- a/configs/qemu-riscv64_smode_defconfig
+++ b/configs/qemu-riscv64_smode_defconfig
@@ -19,6 +19,10 @@ CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_SPAWN=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_CLK_RPMI=y
+CONFIG_RPMI_FIRMWARE=y
+CONFIG_RPMI_SBI_MPXY=y
+CONFIG_CMD_MPXY=y
 CONFIG_DM_MTD=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_SYS_MAX_FLASH_BANKS=2

-- 
2.53.0

