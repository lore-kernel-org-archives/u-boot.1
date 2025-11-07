Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA798CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 09:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE5E183C94;
	Fri,  7 Nov 2025 10:00:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QXBnJtq+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C090083CAD; Fri,  7 Nov 2025 10:00:49 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D84B783C60
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 10:00:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1762506042; x=1763110842; i=xypron.glpk@gmx.de;
 bh=uq6FK8/pRJG2TlyYP4YkfULU9er7eA5/PRTg82h5ngI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:
 References:To:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QXBnJtq+gS2kL50OfLvCP5qEa4cqkzs7b41swLhOsHZElmtgCpMvP8LxWkxrto8T
 9GBW2IFtaxBJuf3kq0mHOlrWkmZEdsKwL8Vx3TSOACllunAImlaszu5/eJj1ZJbJG
 4A6WgkfZ2oBYbFUf7cts+NT7JZVQIYpm+7dcpjt+sfdGBFEA9bs42wLzfe2e/iHqF
 NIWq+CnjTGPqsJT6Tw0CfVnNx614zvKpYhiBIahxVzf/6lEePhI1Vk5M6+kA8bxJ/
 r8SB3XLTcFKEOU+yundpR/byH3ni3E+TTGyb6GigTRB3XKAjoGNqEmBb0dAmRtDI2
 CvfV+jSHTFtf7GRWKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.183.149] ([93.94.208.154]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MC30Z-1vMUK70A05-006335; Fri, 07
 Nov 2025 10:00:42 +0100
Message-ID: <dd079318-795e-46a9-8123-2e8b7c5758fd@gmx.de>
Date: Fri, 7 Nov 2025 10:00:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Fwd: [RFC][PATCH] kbuild: Produce diff between base DT and U-Boot
 augmented DT if DEVICE_TREE_DEBUG=1
References: <20251106210826.371672-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
To: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, E Shattow <lucent@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251106210826.371672-1-marek.vasut+renesas@mailbox.org>
X-Forwarded-Message-Id: <20251106210826.371672-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FOMJaRCERrfoxjLb/8CbaeW6Lgcn68lgmlLT4D3PkGQwryvIhGK
 xvJ/EfLvzZsoPQhAJWnfhkbm2Jl/QPt1HBbGVEdH/4/f6jaQuhxQJaJ5GCmhJW+ykZLbOwP
 NRTu1yrKcYO/GJ1rWQS5US3Wffv0S0VFxYM1J4lkoqJKZsUtb1mIAzZEzwPUgc32fxRyPuH
 03KbcUbEi5v6MITvRamPQ==
UI-OutboundReport: notjunk:1;M01:P0:Y0cAx8z7yyE=;iLTypP0vbfiSov5ew0RKz2d5KAr
 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
 tk0T1pZSn/jMwT1Fc=
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


Hello Hal, hello Minda,

Marek created the patch below, to find differences between Linux=20
device-tree and what U-Boot uses.

For all JH7110 boards I find these differences which are due to=20
arch/riscv/dts/starfive-visionfive2-u-boot.dtsi. Could you, please,=20
check if these are still intended:

@@ -533,7 +617,7 @@
  			#clock-cells =3D <0x1>;
  			#reset-cells =3D <0x1>;
  			assigned-clock-parents =3D <0x28 0x0 0x28 0x2 0x28 0x2 0x3 0x59>;
-			assigned-clock-rates =3D <0x0 0x0 0x0 0x0 0x1dcd6500 0x59682f00>;
+			assigned-clock-rates =3D <0x0>;
  			assigned-clocks =3D <0x3 0x0 0x3 0x5 0x3 0x4 0x3 0x5a 0x3 0x1 0x28 0x=
0>;
  			bootph-pre-ram;
  			clock-names =3D "osc", "gmac1_rmii_refin", "gmac1_rgmii_rxin",=20
"i2stx_bclk_ext", "i2stx_lrck_ext", "i2srx_bclk_ext", "i2srx_lrck_ext",=20
"tdm_ext", "mclk_ext", "pll0_out", "pll1_out", "pll2_out";
@@ -996,6 +1080,7 @@

  		memory-controller@15700000 {
  			bootph-pre-ram;
+			clock-frequency =3D <0x855>; // 2133 MHz
  			clock-names =3D "pll";
  			clocks =3D <0x3 0x1>;
  			compatible =3D "starfive,jh7110-dmc";

Best regards

Heinrich


=2D------- Forwarded Message --------
Subject: [RFC][PATCH] kbuild: Produce diff between base DT and U-Boot=20
augmented DT if DEVICE_TREE_DEBUG=3D1
Date: Thu,  6 Nov 2025 22:08:18 +0100
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.denx.de
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Adriano Cordova=20
<adrianox@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias=20
Apalodimas <ilias.apalodimas@linaro.org>, Peter Robinson=20
<pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>, Tom Rini=20
<trini@konsulko.com>

In case DEVICE_TREE_DEBUG is set, produce a diff between the base DT and
DT with U-Boot extras, to show how much does the U-Boot DT differ from
the base DT. This is particularly useful together with OF_UPSTREAM, to
minimize the diff between upstream DTs and U-Boot DTs.

Example usage:
$ make r8a779g3_sparrowhawk_defconfig && make DEVICE_TREE_DEBUG=3D1
$ cat ./dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dtb.diff

This still has a downside. Even 'dtc -I dts -O dts ...' applied on
base DT and U-Boot augmented DT can produce different phandle IDs
for the same node in those two DTs, which results in a lot of noise
in the resulting diff. The only way I can think of is to patch DTC
to emit full paths in those phandles instead, something like a
phandle =3D <&{/full/path/to/remote/end} ...>;

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
=2D--
Cc: Adriano Cordova <adrianox@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Sam Edwards <cfsworks@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
=2D--
  scripts/Makefile.lib | 24 +++++++++++++++++++++++-
  1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5db2fbc418a..2d8bf3c04f4 100644
=2D-- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -386,10 +386,31 @@ ifeq ($(CONFIG_OF_LIBFDT_OVERLAY),y)
  DTC_FLAGS +=3D -@
  endif
  +# In case DEVICE_TREE_DEBUG is set, produce a diff between the base=20
DT and
+# DT with U-Boot extras, to show how much does the U-Boot DT differ from
+# the base DT. This is particularly useful together with OF_UPSTREAM, to
+# minimize the diff between upstream DTs and U-Boot DTs.
+ifdef DEVICE_TREE_DEBUG
+cmd_dtc_diff =3D \
+	$(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o=20
$(dtn-tmp) $< ; \
+	$(DTC) -s -O dts -o $@.clean.dts -b 0 \
+		-i $(dir $<) $(DTC_FLAGS) $(dtn-tmp) || \
+		(echo "Check $(shell pwd)/$< for errors" && false); \
+	$(DTC) -s -O dts -o $@.full.dts -b 0 \
+		-i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) $(dtc-tmp) || \
+		(echo "Check $(shell pwd)/$(pre-tmp) for errors" && false); \
+	(diff -Naru $@.clean.dts $@.full.dts > $@.diff || true)
+
+dtn-tmp =3D $(subst $(comma),_,$(dot-target).dtn.tmp)
+else
+cmd_dtc_diff =3D
+endif
+
  quiet_cmd_dtc =3D DTC     $@
  # Modified for U-Boot
  # Bring in any U-Boot-specific include at the end of the file
  # And finally any custom .dtsi fragments specified with=20
CONFIG_DEVICE_TREE_INCLUDES
+
  cmd_dtc =3D mkdir -p $(dir ${dtc-tmp}) ; \
  	(cat $< > $(pre-tmp)); \
  	$(foreach f,$(subst $(quote),,$(dtsi_include_list)=20
$(CONFIG_DEVICE_TREE_INCLUDES)), \
@@ -400,7 +421,8 @@ cmd_dtc =3D mkdir -p $(dir ${dtc-tmp}) ; \
  		-d $(depfile).dtc.tmp $(dtc-tmp) || \
  		(echo "Check $(shell pwd)/$(pre-tmp) for errors" && false) \
  		; \
-	sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp >=20
$(depfile)
+	sed "s:$(pre-tmp):$(<):" $(depfile).pre.tmp $(depfile).dtc.tmp >=20
$(depfile) ; \
+	$(cmd_dtc_diff)
   dtsi_include_list_deps :=3D $(addprefix $(u_boot_dtsi_loc),$(subst=20
$(quote),,$(dtsi_include_list)))
  -- 2.51.0

