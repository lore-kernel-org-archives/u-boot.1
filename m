Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0D6606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 23:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JhRjPPW4;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mUl1ZVJY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4ADD96064E;
	Fri, 27 Nov 2026 23:29:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zRQWjwfrM7fK; Fri, 27 Nov 2026 23:29:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6A9276061B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795822172;
	b=DR6HEiBL132R3ssdtq8Z/sKledoMTeqowLZcquSOuWUYZMRB2XCNVSsT6kCKISkQx83K
	 lY25Ssn7u+Ae2YB0hhHX4TQ+ibPGDR+NQLZ3hS4Gj+05cHPmKv2qHZn6jc9xpgtNVMts8
	 q08tlQmblOo5bU4a0gRL6paxUd4pNgF+6gSgss+a4Ir78oKoZOknxNZQuHId7woBYhr2S
	 E8LGx0Rmjw966dZjSR0IEVM9hCHMJs7IhGcX4yu9Rrbx+uIYHTQOAKml+lWojnsxRF6wh
	 T6tNciEzekjd+nJXthaX2ty9+0sPSYPJV4lxTyvvQRSt0JaOrKYyishDUf+tGL/OosQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795822172;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=U0MxB/X9dac5fzJfprVWkDwEoVZuVhO5L0PDhTER49w=;
	b=JnLOftADWDyeaXYAhDNTL3UCIj4TMWCtnMc49el7xwNFrUT2cXfKQwD5QI92U+xFSPYr
	 5ph2mar1w+LzcXPLHV/eBgfYRxX/VagSJlqj8drmyyg9IpIsdpZDUUEgAPDp+8xCFaXWB
	 1FoKKla5zpJqk6WuyC7NiUc6TScek+54xBP8+5wXn9hCdCCnxseG8M+5WneuE8Apy+AJq
	 HQ6E+wkNujg9vG8gWq/hAsWEZV3hZLsKJAijOpG93m+6HpBgpZPdFAb1GuVCnaSHdJQZU
	 4Sq8dPb9C97xyW266QSdhDoPs2ynV9caEwDIGQy6pzl4Ohb7E64S09La03NDn6dfFIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795822172;
	bh=U0MxB/X9dac5fzJfprVWkDwEoVZuVhO5L0PDhTER49w=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=JhRjPPW4IhAGdIzVju4VAd/mL6tfnq9KqL99GHnR+8v5n96yBODlvp/KTRIdHZ/mi
	 BJOmBQwKahOqigcN3Lvr1Hn4G4a5IWWYf9k3gU+1JSY4GB1P6rG09jJdgzqpnZ62fv
	 wnjxskFXknphXPgmMshhC9Fos1Yn86077JoQyMeOS6xLd4FdGujoSYZYbwUkiq3Z1j
	 25Vdew6xGh2dCw3/D8X3MUJLoWCuIf61ewj9Hbi4gn3CN4S5EohukHJfqyE2gkFeEN
	 zqiw0DMZJ52JqsEv2UTjsoENf/htvW8TnW0nCuQ1v+d2cjBZDtqKxAfLSEikaimPaK
	 TSD5BVFXwcNyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A9276061B;
	Fri, 27 Nov 2026 23:29:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 86A7526D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 23:29:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8415740569
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 23:29:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3QfTVCSo7ur7 for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 23:29:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 83EDB4055A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=devnull+iav.iav.lv@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=mUl1ZVJY
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83EDB4055A
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 23:29:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 042006013B;
 Fri, 27 Nov 2026 23:29:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 9AE941F00899;
 Fri, 27 Nov 2026 23:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795822167;
 bh=U0MxB/X9dac5fzJfprVWkDwEoVZuVhO5L0PDhTER49w=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=mUl1ZVJY+qnLBpwmnYkvNNoU/snN9BvHqjtYbIrs5MKjzK+SyCii7v24xPl5SyjmG
 4g7+ge/DytYRkqENXiwEVx7Nf+544LV9HKO0SMn69QMns2uNauI4GXZCwx6WiEH7ls
 4l1Iuf6CEY/FAZiW6/Yh8lQBNkQRiO7ssCxrLaQwkCyo/s/x+scucc0+nDL9h5ZfhQ
 VDs/w1BxNGipRT5CLOFFsST+3I0SPgrIzvhKetXjxBbfbKham9Pg+WlcE95l0mOgCQ
 sGqtnsXHG5Rm0L0FnRT82lPxYuTIZAyEpBjKtdvp5ApQuiVH9lbGQs5OF68qP1Q9ix
 CK9Uv8hATg+fw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 2A6224DE75;
 Fri, 27 Nov 2026 23:29:20 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sat, 28 Nov 2026 01:29:18 +0200
Subject: [PATCH] arm: dts: meson-g12b-odroid-n2-u-boot: limit the eMMC to
 40 MHz
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261128-n2-emmc-40mhz-v1-1-fbfa199affdd@iav.lv>
X-B4-Tracking: v=1; b=H4sIAE0SCmsC/x3MQQqAIBBA0avErBtoVDK6SrQIm3IWWihEJN09a
 fkW/xfInIQzjE2BxJdkOWIFtQ04v8SdUdZqUJ3qidSAUSGH4NB0wT+oedicJXLWaKjNmXiT+/9
 N8/t+sV22IV8AAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sean Anderson <sanderson@brivo.com>, u-boot-amlogic@groups.io, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Nick Xie <nick@khadas.com>, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1977; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=zSkjLbhWCVDhiJZZwds1KL7JCuIcaS4Ezoeg897SLYs=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDNlcQv6f9x67foVvz/UXbOtk1z/wmC+lJrr/nj4vR6NlK
 u/1I/PtO0pZGMS4GGTFFFkmHNK4lbHk6l9/D/MHMHNYmUCGMHBxCsBEQj4wMmzI67B8tNHen81w
 wZX9E6Ye+HHq/8UGeaXAjB0i7h0bp2YxMvxNVBJismuTr7vbE35a1sn4/6L1qhEela58pQXdS5R
 mMgEA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: iav@iav.lv
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Igor Velkov <iav@iav.lv>

Since commit f7e3eaebd300 ("mmc: meson: Parse devicetree properties")
the max-frequency of 200 MHz from the Linux DT replaces the 40 MHz
limit of the driver, and U-Boot runs the ODROID-N2 eMMC in High Speed
mode at 52 MHz, 50 MHz after the clock divider. The meson_gx_mmc
driver has no tuning and uses a fixed clock phase, and the defconfig
has no HS200.

On an ODROID-N2+ with a Kingston 128 GB eMMC (Y29128) the EXT_CSD
read-back after the bus width switch then fails with CRC errors on
DAT0-2 and DAT5 in 8-bit mode and on DAT0-2 in 4-bit mode. U-Boot falls
back to 1-bit, where multi-block reads fail too. At 40 MHz the same
board runs 8-bit and a 256 MiB read matches the crc32 from Linux. The
same module in an ODROID-N2 ran 15 of 15 starts at 40 MHz and had one
failed session in about 120 starts at 50 MHz.

Limit the eMMC to 40 MHz again, the limit from commit 8fa0db145f6b
("mmc: meson_gx_mmc: reduce maximum frequency"), which is also what
the Hardkernel U-Boot for the board uses without HS200; the ODROID-N2
and N2+ share this DT. The limit goes into the board DT rather than
the driver, since the DT describes the hardware.

Fixes: f7e3eaebd300 ("mmc: meson: Parse devicetree properties")
Signed-off-by: Igor Velkov <iav@iav.lv>
---
Tested by starting the builds with load + go from U-Boot v2026.07.
---
 arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi b/arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi
index a92f9e9ff13..d6cb2f3c245 100644
--- a/arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi
+++ b/arch/arm/dts/meson-g12b-odroid-n2-u-boot.dtsi
@@ -11,3 +11,7 @@
 	status = "okay";
 	vref-supply = <&vddao_1v8>;
 };
+
+&sd_emmc_c {
+	max-frequency = <40000000>;
+};

---
base-commit: 40bafcab3bea0511eb3925da2f0fdc1df9758e3d
change-id: 20261128-n2-emmc-40mhz-3e8fc711c743

Best regards,
-- 
Igor Velkov <iav@iav.lv>


