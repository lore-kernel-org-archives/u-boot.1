Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6C4C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 06:31:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 810E660721;
	Tue, 15 Sep 2026 06:31:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Epsl7SR8k47D; Tue, 15 Sep 2026 06:31:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CAAF760708
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789453883;
	b=DKaPzOl7W0AZVsJXlaGkqT85ZImKogOe0H/rYFh4PwOU53iqiHZs28ZgV8CGpw0nqa+Q
	 KwdvzukxpNF9VRQgL4YX+7VDTHoiCZxonW1+XJiCrIksPRp1n/Sj7yXwijHfKQ7h9y1vo
	 R5dTMDKcpgInDuPxcL08LUGbU21FsL0I7vhk30Ll/oUtHVLGEkR3Kxl3xWq7C58KvFEXj
	 Rq2rFVBm9XBEFB3HSTJFu9/ka+whSXl2wACPHX6u4cVcM8bJuDL4rHxCPEErtgCCYsY5i
	 qyXLba+Oa8gOi3XMdiJF/DsE6CmMkleu8up6eLY49K1IV891Yt218u2ZBx9acqfTSyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789453883;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VR1PPX9obJ3o+uS66EzhGLCiFm3tXziRDwhWkBB5HL4=;
	b=YaVjvpJ1TgeXeDxQtCE371UXSpabTjU0i44sxyDeKZff77Twi4jcpK2r6Dypq4vA6vou
	 PYegetBBXJS3m4OD+HbjHKMRH7PDrKvXuJGFwvY7pnK6hJ9h9gEBpaoeuxAZAlAEEvzkN
	 keSh5bjbiKXa6QYrMCbeZ3JzJxrM6QZppPTKAODMoa0cgMuUZQRKbTpQgxcNkK4QqLmHO
	 4Erm2N+zQSXjCzFV5BumLHz9b1kZwki2/x2gyDShTVfpPtGUh0YT92f/8iGsuh5eZeRHB
	 8Eq1FwoW5oG9q0eeJdHGJ99JQ5lpvjp5dM04Z2esS/ZmMZvTXm+FYfmG2/AdtixKTqg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jbxkIWjJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789453882;
	bh=VR1PPX9obJ3o+uS66EzhGLCiFm3tXziRDwhWkBB5HL4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WGmWj+mCwc0dFY9RKlfxOctQp93AzrI/81ug5Sm+sV3ePzBW/2hUHhrW3Ik7gXRh4
	 s5S+tP8KVidxtWacVIlVec6EkTtxfbf45DfzovnpwZXkbfgnuOEA0cRsjk/tEIFwEk
	 6gNcpaBDp5RXUSooaYsoeKWDfTK0NAbJtmLjqfGNMUhgWfXk6MYSzq43k8m5v6f82b
	 Y6eNHmvpnLtKG/00UPz1SNRzlhEiSfQ2txkc2fU27FX1uHw+z9tUQSWLWaT75NGiFh
	 wLS9w6WTWmLfZGxOKG4MGULqjA497Jnyuh+M5Oe1GNS920GihcJ8jdyyMWKA9xpo/s
	 ph5HZ58dDTdUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAAF760708;
	Tue, 15 Sep 2026 06:31:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 049F7493
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 06:31:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA90860708
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 06:31:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gsgSvOe6eqIY for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 06:31:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4353A605D9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789453880;
 b=OaitxuRagC1MexVZxydV9jFk+IuiB/lSMh8IatpBns69NZvtpRtgGUXTWx2R8HRruDHw
 qoujj0zrdlhWHY7NPsXoiLw8Rwn+L7cmkddqc0WHiZYQXQtqLCgFf+o2X9TKIdF6RtUH9
 l5hsn5OnupHkxmXEMjCHZ+Bm3WkuO44KKfmKnrQWpZuYsH71qHNHtTZiFX86C2xf7c3o8
 tqD5HjTPQsgDubKj3if2xY01zpSZjGLFJ56VCWrzgmF/9ubexG1jEk0aYZO/jp6iZZz/C
 xP/omQ9jCHquiNIWyPHOUZ+hfwgGjo1LZhtVtpzvmbrJqJVrAkThwrrsPHi2u0p2AXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789453880;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=VR1PPX9obJ3o+uS66EzhGLCiFm3tXziRDwhWkBB5HL4=;
 b=TyDqXIVYkW82hK1TYcz/mBDW52zRG1WGLcJk+O4ceuDlE4OZsLOoxxIsaLVW15TnPNxf
 8poWGLynPkLsk26RVeVNvMpkLBp73pc93A8mIUNTrMpDniRFyfftPQQCrSXt8KAN4R1lf
 G045/oGmybl9COkeH/tmFD53NZBi1dhdrERKhSJlyKmhtb6T1gToDzv3lnVSV2Bk2XFr7
 fdyV6CXIxi0luyUgc1zuETDuZGIG2FWW8Ct+tcP1E6AmyL44wSkiM79Nyaizx6AGayZNK
 m/jUp0NdSrS/WSdacGWCuvDTTOe5jRiIsJvAdWPmIcFt6BZuQX3r3VTvIBFQ2+YDn4w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jbxkIWjJ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:3b::f;
 helo=mail-pz2-x0f.google.com; envelope-from=imkyufie@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jbxkIWjJ
Received: from mail-pz2-x0f.google.com (mail-pz2-x0f.google.com
 [IPv6:2607:f8b0:4864:3b::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4353A605D9
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 06:31:19 +0000 (UTC)
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-85469d249c5so2416744b3a.3
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 23:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789453879; x=1790058679;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VR1PPX9obJ3o+uS66EzhGLCiFm3tXziRDwhWkBB5HL4=;
 b=jbxkIWjJenlJXB6wDG9svNzoNkm/hFn5btAz40GHUmNZOeUWBRojb21rEbcwGrckQK
 bsy8Vs99xwX1zFbXpAdxA8zZZQo8iPZDPfFds+Xpxo1nNZXc3SXDIxDjlpZH8G8JpdqU
 NIo5rcktGV0rNG8WzVXG5bDvCji8YpeNvF42D7PECy9R+qnxmVus/mMxK2c5FagU1wdZ
 H2R/J5pKE2cM1AnIkdOdgxx5nujMsvKZNeCZl8efj8aWnbcXoS9/ROSa1KVjyKBwLCoX
 locmh3EqMGKIykBMnxPaEmxrexr2AHG4pTBAp5/0x7Y0Bp68M4qQgCddLZoLdejwMctg
 yNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789453879; x=1790058679;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VR1PPX9obJ3o+uS66EzhGLCiFm3tXziRDwhWkBB5HL4=;
 b=hnBIs0ve8WJwPqEH49eW0OlJtJwBOuwfpUskdSrVx7Sk79yaqnSVe/OJXRVT+Ythmb
 xArFTICcTfRRXHNKmRHXcllaxq9vlJz3ybdEnm5gpwvVCtGSZrF+K+G3X2iWm6ZvADNj
 UOrSBv2DmURpyl22649ObWK0Y4uqEpnbRvifnZUBTBgne4OoR3z+jlc3ow6RGNJJWIhV
 q8cpDjW1jxMlMJnLjoPeF4OKx5htIi+FJ6iGp5b03DaeOhWOQxU34FTP4JSfj/jZ/AQ1
 P4g0k0nN47xxRFCMz0FUQumAnIJyN8yFstMrrv3HdHhLYqBbWHzlJ11526acSep07CuW
 5rzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmfCBsJtZoesJ4FyRug+60gzmQnpv9H6CAedi0PUmpNa7UF1z0vzat64JneKvDe9dO1X30Hag=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lpXxFntL+f/PTkv9l/1icMFVXF9Duce5H6cV5niVqab7e4ZAgW
 2BHEFFrkA1R3hkvAB4Q1tfbFeTcbJQtRcl12S3uayfenOIS+mehf92P8XFPJ2g==
X-Gm-Gg: AYBFou1v76tfrdtJnY5xZhCjOnYXVZoZZr6d0xWCpODlEXeGMUAKQ35DcMUwEO7WrkB
 3Nch9qRat2Op+5JoCsqQVmOUBsm8C5S5WBQrIW/THQ+tL387Qd3gtZuYKzzb4hQ7+E5aL7W1NvW
 UxqTyDqAR6o2glACN3Zmv1+Id0b6KYyuC1MzwzlYfTeuhhqCmV/C3pWJDyypiwG6V4/qEB4frUh
 e7Ugk4TPZKWYTRJbC9+srIrvmSquxNRHZbnZ8AYEM6gm0CuCmk+T45+xvYpQCIhTUQ2p7yooC9e
 GRayggBv1Zf5HYvNSbeen6DJiiYBf1aL4e5FsUnU9cl522GC4qzLVbiEynI8RSIJle8p7qybw/B
 ZM8eURMvBZyjnqXnOSzmmtqJFXierrAklBCzjDtkAdTUd5SllHZb675e6LT2Al2TKRsY0VM4+9/
 O1UcCdYohYEP5weK9jTE4PESL7KENl4lutWl9Req4Rl95uHu9G4Ho16COq+Yl8sEGropmXmxU=
X-Received: by 2002:a05:6a20:914c:b0:3cd:67e9:8565 with SMTP id
 adf61e73a8af0-3db404225d9mr12609931637.9.1789453878616; 
 Mon, 14 Sep 2026 23:31:18 -0700 (PDT)
Received: from [127.0.0.2] ([103.255.125.189])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc4c6528fb9sm5991076a12.10.2026.09.14.23.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 23:31:17 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Tue, 15 Sep 2026 06:31:06 +0000
Subject: [PATCH] rng: msm_rng: Acquire optional clock even when
 initialization is skipped
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-qcom-rng-fix-v1-1-c7405eebba63@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAMBTG8VfRuXZqJItXkYvZzjjKsCEl7264/
 H31/S8I5JkC1MkFng4OPLuILE1AD8r1hGyiIRd5KaqswFXPE3rXo+UTlTSq07IURlmIl8VTnL9
 c0/4OezeS3t4G3PcDyB3vjHAAAAA=
X-Change-ID: 20260914-qcom-rng-fix-a7dabc760daf
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Cc: Robert Marko <robert.marko@sartura.hr>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>, 
 Reza Kurniawan <imkyufie@gmail.com>
X-Mailer: b4 0.15.2
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

For devices marked with skip_init ("qcom,prng-ee" and "qcom,trng"),
msm_rng_probe() currently returns early before retrieving the clock.
As a result, priv->clk remains uninitialized, causing subsequent calls
to msm_rng_read() to skip enabling the clock which may cause failure
if the device boots with the clock disabled.

Move clk_get_by_index() before the skip_init check so that any clock
specified in device tree is properly recorded. Additionally, treat
-ENOENT as non-fatal so the clock remains optional for devices (such
as some "qcom,trng" nodes) that do not define one.

Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
---
 drivers/rng/msm_rng.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rng/msm_rng.c b/drivers/rng/msm_rng.c
index aab602c5e..68f25ac51 100644
--- a/drivers/rng/msm_rng.c
+++ b/drivers/rng/msm_rng.c
@@ -114,13 +114,13 @@ static int msm_rng_probe(struct udevice *dev)
 	if (priv->base == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
-	if (priv->skip_init)
-		return 0;
-
 	ret = clk_get_by_index(dev, 0, &priv->clk);
-	if (ret)
+	if (ret && ret != -ENOENT)
 		return ret;
 
+	if (priv->skip_init)
+		return 0;
+
 	ret = clk_enable(&priv->clk);
 	if (ret < 0)
 		return ret;

---
base-commit: 0e2a0ceeefa0ae10118b8364da62f1fb86f286c0
change-id: 20260914-qcom-rng-fix-a7dabc760daf

Best regards,
--  
Reza Kurniawan <imkyufie@gmail.com>

