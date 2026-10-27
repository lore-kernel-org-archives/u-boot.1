Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB3606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 05:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xgGNvI3e;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PwQ52dQv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E60DB80BEA;
	Tue, 27 Oct 2026 05:57:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dsZXOuui87rV; Tue, 27 Oct 2026 05:57:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D000980BE2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793080654;
	b=mx2A0fqm6WSlvSjnrFNjWiGNvXU1K5M2LcGDHKzOLMRAqA8PtSYU5XIENpSNaXEaVGhC
	 SlPzqUeJu0b9IE4XAPWfVx9BeeVt4JbHsyDzDUG8A4j1759u6tU3LejaoCO8vmnbF2VQT
	 TUdQAvKaLBFnh7AWn63lNpMGctG6EIXD4Ev2Lannxty2aLwnlIybNDxrmgkk6t4ssfqqD
	 BoYpyb9o3FYOOojVsFC/cjirHtxv1w4RqcsFVmN09DVU8EMF4g3k8fn+gAAfTmNWo+xH/
	 q+H/LpAMuVodnBeW0/Lb2YjXRCptLvLEe7g44U9owtnswuEtR+QcGtPUqmYN/jv63uw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793080654;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=DUXz+91YyfWK7aK6ialXBV2YaunKby69ESswzYi09cI=;
	b=f39eUtW+KDE56JASzm7mmfQJZeEEXF1YIHS0tPWm5OgH6QiQsg/JadOmZIVa7NGxJHxW
	 3TXNs6l4YgAls1uAIQXeRYT0KuoEp0yoKkOTm6JaBMNachME3VNUlTaFDrh9a0ZPuHrxO
	 GFUJxJeDHFIhQKwC8+gA/l2QX8NsCpND46bStXse4zjftgPEQDO6Ug6z5YMEipI7ssxGq
	 cjif3DZn/16o9rFG+civzJ2PiRy2w0bIQgnA2osPXg47spIkUOkm99dv/SSCFkqGreYir
	 7t2V+FfBIbwYIko/WADDIwC8g+73pyPZf5OfQtAgWovIowti38p/WyLEnEeSk+R3SLg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793080653;
	bh=DUXz+91YyfWK7aK6ialXBV2YaunKby69ESswzYi09cI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=xgGNvI3e8226ESckR791dp1fBa82RTAI+qIY3PuISeloiRj+ZPDSJqG3akPHZhbsX
	 +IdqIphrwdfThcj3bmd3z7ipaTN24mkmqcPp+PmnP0d+L5LXVH6xm62anABPU7kF+1
	 v6p4LHzy7wT2DOQMnAFsVFB3l8IjSwWQbIVm+/NB0SAroreNglWVtuhmJPXrQtsjj3
	 8yqQuBLIHAf+4U08rr532f108HIL8FJ7KUjDTJ7Yh9DQW2QDNW9KaSz4JJklpEO6i6
	 6RtZ99YEE/G5oQHxo9FwhWMFFw7RdRAjInO0ZcfEtY6itim3ndYdq1Y5qvuDF+/kTt
	 Fu8wGKQIg9y1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D000980BE2;
	Tue, 27 Oct 2026 05:57:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C1538356
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B2E77400A8
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:57:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y5WxqCKZa03K for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 05:57:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A089340062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793080650;
 b=tZwN9847i0+Xgvr7iuSTsVVdPkcM6tjPnIVs7SULAMQXVZ0y6E325oMyDqf/QFGyei9Y
 UsZoLFqBYYj1kaF9Agk1BnZXYsHPnBZEcSnvVGrquOp3+1jo73+em2Syyr/LfzMoTcMMK
 Ah7L7lRL876ajBGTvKwJXNNhZVinNM0IprY9uGfVHhwaDK56x24UC1kvGZrDwWXPP3Y3R
 2WVQaAh0OcFZkJGB+D6+Ur6CGKkk6LgUz9315cQkQnfaJ9V8No92iB17ktIpXAsIOMGlu
 BH0M8CRW1YW9c80KnncTGtVAzSqpmayXVYD3xaob4XyJiuMTfFlyNAe+v8hzblzqV1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793080650;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:X-B4-Tracking:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=DUXz+91YyfWK7aK6ialXBV2YaunKby69ESswzYi09cI=;
 b=L/MLefAiJ3vEhs9/wUCLcOvGmhTZRzjYB4xn0ubaqj1dLeq1CjlYq2XH3ehfHWZF4t+W
 SmYDmiLpgoUlCzzOIJduQ6flQi+qUcnTVkFzVy2+tGchHBPqrWU36cziIWdZnXpQqHUiU
 h2kPud+Lg/hHQdLczkAPxx3hZmepBUUeWVtIJ1htyN6EGBl/h6yyBwmNw6WHR4EuOk0ci
 +EJiT6E5UF4X6ki3L+q0ZKW5BpUjp/LHKshgVfXkKF6F7XuoG393B/BcR2fPg6Go85Iso
 Bsfee9MOVBLf0KfiXYlSip+fhNlkGrUU/lLEqvZhCOMZXz0LMDX0PV6wbS4ZQZqGY4A==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PwQ52dQv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+iav.iav.lv@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PwQ52dQv
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A089340062
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:57:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 52719419D4;
 Tue, 27 Oct 2026 05:57:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793080649;
 b=TVicKfJMBgJ6uYX5iF7c07ByV6OVwdg11ysqXMtfjIg6E9/1V3bRcT8s5USNW//Sca34
 fjrg01awpTjEsl4ZS4f0j7wN6wexCiAwqBq+RO/t+o/GEjIp2xAiw/UCO47wmENm9TXMD
 vI98tC2ApYLSi+tWWbUl7H1C/DfLNi8k5Vr4KWlgXkL4V3YoNQSMiPqhlGPvgVHa2YU3d
 Ijob5+OAqh56AVihFf7cXHkI2Yj3KOgfglBXuNRJspMvHOcodhEJDmH3KyTl0EsNT1s7S
 Ts0uKmUaWJltD8sX6egnv7uHpQJp30ZSC8I2mAILrl3AxBHUObfLKqRI5rx0WiCj2UA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793080649;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=DUXz+91YyfWK7aK6ialXBV2YaunKby69ESswzYi09cI=;
 b=YETVW1D5ZRSYsUaO1WaUKUSi6djEVBuqK1kOY5YwEqKngkPo9YmhDXRUBZ7CYhqndVY9
 y5vVCQW78Qu/ODhAukh6ONGnrBa3sCenGLeSCwIld1uOc0/I+f99b23xDKeKLz4YBpxZw
 7waq3SomLN5B5/GF+6PI/b/5FDxxo0OouWUOWeeiWbyeXSf5X0e7Y2CXSq99WzW8//fPS
 ILIjzUHBeSW9FEuQYy/EhlOHbuCE1l9obqZovqgCMP3wHWNLXR95j/4PQpKdbjjRe4d7N
 pwMzwBiRBDAu56Kh9+6IScSDTCR/DuPTPZD10Yqf/7OR7vuioq5aEYirRT1RltJIITg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 982121F01828;
 Tue, 27 Oct 2026 05:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793080649;
 bh=DUXz+91YyfWK7aK6ialXBV2YaunKby69ESswzYi09cI=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=PwQ52dQvVrTpTgiSJGo5TfqWXVkqUMcQxJFGPmGiQbPQuzxWk+oYeD3bLCaIVhDt7
 PagfUGvZR8cSGzVnX8Gb7z6B2eKuLC1i6tQlyPsh2riMFpilSNDPzDTE0KdEAXFqgN
 ntLFbtYwMp1XV8fy01RE0vYLnstHrblCxVbnfINNb1NYGb8tNLKDk7+jte+nZguzqQ
 TMRBTDS0iOS8yqAU7okg6l9qD+B0/p6P3xWNuO191WbN0jpHs1svui0c5KMXkuS+IT
 yCVXp3wS+QAAoamCONpGHncU1soTxlluIRrOwemjl7oQlrUDKOdjv0kjNLqolPdkWa
 nydxIImMLU9Tg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 295A844FCE;
 Tue, 27 Oct 2026 05:57:28 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Tue, 27 Oct 2026 05:57:26 +0000
Subject: [PATCH v2] cmd: sf: Probe a flash at the requested speed
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261027-spi-probe-speed-v2-1-2f27ddb6a03b@iav.lv>
X-B4-Tracking: v=1; b=H4sIAEU94GoC/3WNwQrDIBBEfyXsuVvUBok99T9KDhrXZqFE0SItw
 X+vzb23eQPzZodCmanAddghU+XCceugTgMsq90ehOw7gxJKC3MRWBJjytFRT0QepVbToqeRtBq
 hr1KmwO/DeJ87r1xeMX+Ogyp/7X9XlSgxBGPJBXI+mBvben5WmFtrX6aglCqrAAAA
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut@mailbox.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 u-boot@lists.u-boot-project.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4412; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=0HDgpoWNl/+3OQN05UdUj934gpGhIHKqqblVEey/MMY=;
 b=kA0DAAoWMpeVi+pfeQMByyZiAGrgPUejvnbwwEYuhzU1cPbtbuBpuZaiVTTrQkloeQgblezKo
 Ih1BAAWCgAdFiEEkMIo2mik1f1PSDfgMpeVi+pfeQMFAmrgPUcACgkQMpeVi+pfeQOrNAD+MG71
 2xIa8Q1/eSJu1BF9v7QRUnC9wI2BMQRJKb/WqnkA/2RJqErJ5pmc1UpdU5AvC8i8b3ZWbkEh2Zi
 WAqpFvvID
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Igor Velkov <iav@iav.lv>

'sf probe <bus>:<cs> <speed>' ignores the speed for a flash that has a
device tree node: the probe, and with it the JEDEC ID read, runs at
spi-max-frequency, and the requested speed reaches the controller only
after it.

On ROCK Pi 4A the device tree sets spi-max-frequency = <108000000> and
the flash does not answer at the resulting clock, at any requested
speed:

  => sf probe 1:0 1000000
  jedec_spi_nor flash@0: unrecognized JEDEC id bytes: ff, ff, ff

Before the probe, set the requested speed in the platform data of the
device, as _spi_get_bus_and_cs() already does for a device it binds
without a device tree node, and restore the saved value right after it,
so the platform data ends up unchanged. slave->mode keeps the device
tree value. A speed above spi-max-frequency is honoured, as it already
is after the probe. Only sf probe with an explicit speed changes: sf
probe without one and the other spi_flash_probe() callers still probe a
device tree flash at spi-max-frequency.

With this change:

  => sf probe 1:0 1000000
  SF: Detected xt25f32 with page size 256 Bytes, erase size 4 KiB, total 4 MiB

Add a sandbox test for it.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Tested in sandbox (the new test fails without the change) and on ROCK
Pi 4A with U-Boot proper chainloaded: without the change sf probe 1:0
at 1 and 10 MHz reads ff ff ff, with it the flash is detected.
---
Changes in v2:
- Move the override from _spi_get_bus_and_cs() to sf probe, so only an
  explicit speed from the shell changes; other callers keep probing at
  the DT speed (Simon)
- Override only max_hz and keep the DT mode (Simon)
- Test through sf probe on spi.bin@1 (spi-cpol, spi-cpha) that
  plat->max_hz and the DT mode bits survive (Simon)
- Drop the wrong v1 claim that the next bus claim returns to the DT speed
- Leave the post-probe spi_set_speed_mode() from e2e95e5e2542 as is:
  SF_DEFAULT_SPEED takes effect there, and 117 of 153 SPL_SPI_LOAD
  defconfigs set it
- Link to v1: https://lore.kernel.org/r/20260930-spi-probe-speed-v1-1-ff9aebfebdf9@iav.lv
---
 cmd/sf.c     | 11 +++++++++++
 test/dm/sf.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/cmd/sf.c b/cmd/sf.c
index ec9ebde2aaf..7dabb4d1684 100644
--- a/cmd/sf.c
+++ b/cmd/sf.c
@@ -146,7 +146,18 @@ static int do_spi_flash_probe(int argc, char *const argv[])
 			}
 		}
 	} else {
+		struct dm_spi_slave_plat *plat = NULL;
+		uint saved_max_hz = 0;
+
+		/* Probe at the requested speed: the flash reads its ID there */
+		if (!ret && speed) {
+			plat = dev_get_parent_plat(new);
+			saved_max_hz = plat->max_hz;
+			plat->max_hz = speed;
+		}
 		flash = spi_flash_probe(bus, cs, speed, mode);
+		if (plat)
+			plat->max_hz = saved_max_hz;
 	}
 
 	if (!flash) {
diff --git a/test/dm/sf.c b/test/dm/sf.c
index 0ec02ac694b..ea93f0b65b0 100644
--- a/test/dm/sf.c
+++ b/test/dm/sf.c
@@ -106,3 +106,32 @@ static int dm_test_spi_flash_func(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_spi_flash_func, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+/* Test that 'sf probe' with a speed probes a DT flash at that speed */
+static int dm_test_spi_flash_probe_speed(struct unit_test_state *uts)
+{
+	struct dm_spi_slave_plat *plat;
+	struct spi_slave *slave;
+	struct udevice *bus, *dev;
+
+	/* spi.bin@1 has spi-max-frequency = <50000000>, spi-cpol and spi-cpha */
+	ut_assertok(run_command("host save hostfs - 0 spi.bin 200000", 0));
+	ut_assertok(run_command("sf probe 0:1 1000000", 0));
+	ut_assertok(spi_find_bus_and_cs(0, 1, &bus, &dev));
+	slave = dev_get_parent_priv(dev);
+	plat = dev_get_parent_plat(dev);
+	ut_asserteq(1000000, slave->max_hz);
+	ut_asserteq(50000000, plat->max_hz);
+	ut_asserteq(SPI_CPOL | SPI_CPHA, slave->mode & (SPI_CPOL | SPI_CPHA));
+
+	/* Without a speed, the DT value applies again */
+	ut_assertok(run_command("sf probe 0:1", 0));
+	ut_assertok(spi_find_bus_and_cs(0, 1, &bus, &dev));
+	slave = dev_get_parent_priv(dev);
+	ut_asserteq(50000000, slave->max_hz);
+
+	sandbox_sf_unbind_emul(state_get_current(), 0, 1);
+
+	return 0;
+}
+DM_TEST(dm_test_spi_flash_probe_speed, UTF_SCAN_PDATA | UTF_SCAN_FDT);

---
base-commit: dfcfc4c9f78d1743f490a497082a4ec8e058aae8
change-id: 20260930-spi-probe-speed-1628c684e624

Best regards,
-- 
Igor Velkov <iav@iav.lv>


