Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629E0CCF2CE
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23A838144C;
	Sat, 17 Oct 2026 13:01:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eo2AzuNhgqtV; Sat, 17 Oct 2026 13:01:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 491258148B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242093;
	b=oM5rdeRefcvkmHG6ozoSLEW3jh/Dt68a4kwgnBYSnjvJjiPKVzOu9qvMp2MU/+HPt446
	 dzdDpXtLPzghCFQdox8EDYJBj8vpE2TYsffwc2aJdka2rfavcgxv+xV1rAi5D5GWaBtk9
	 HzI84sWpR6NLQXc7e0oKwLaW5Nm3ZVNSAx7yDiHM1YKE5AclYyGW/oC3V0W3zgSoJbNxB
	 k6+gKu/gSQRwTZ7laTSjDXyO3vpuPZVSNmeiGgzYbj37A21Xg9USXK07Xle/Yochkh+iQ
	 KABlHbAfu64cIUuSCGOBS/cZFzsYS3RftJrYsuv3fxxZUtrEutwAETVtcQh2oMU5GdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242093;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=ix8DI3fhp1FCwHb5OJiPOog0EdUTmBh3EQRFHU9uAlw=;
	b=JzFj1hCAPHnVyo11B8MKlodCtd9IAWgkWUa5/rY8oSiq3wbE3HZy1xCb30M3SmMjigaE
	 oLGxVeAjtQjJMvUmiuic++aEqdzOfzd8uQs/Q36ggCjglBDXT2eG4O5XaDAA3PaJMTHXD
	 4YvH3nqQ1mU3RwldoPreumoSl0nS+gcUPi4HPeQUqu6AUoZjz5mQOt87sl4Aj6M0VpnRM
	 iw6KLKSJr1Q2BrnWpF7iQs9TtYnKGl/co2k03u5tGkC8g8QOmQaYa2nbEMKKhE2A0LXl9
	 mpCuqmjpzub6Hy//B/C/BxaerAhvtOxxnfBPeUyvG9mL1Sore+19/ykQqvGYr45K1Hw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CUiAIeZN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242093;
	bh=ix8DI3fhp1FCwHb5OJiPOog0EdUTmBh3EQRFHU9uAlw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=KfCpxHn22ymUFDHUZp8UUSK+//p0cIfH8t8pHdzN0hfRJDw+c9n+HJ7p7gWDBXk2L
	 EzKqi/uXxdeL5Yh055ueMJmBtRpsYmqYekWLLDTIkdJ46P3dd8b4+zhLRJJXzJpALu
	 3HAgDl6uBb1idDkg+W5uUnTRmYvvyVOo8UFRxY6J9P7IbiMqvJX0mYqRUETtiBB6IN
	 U7cFiZtiIUyEqabSM75Q7WFwbttc/oOG7IOBfC184YZZm+bfJwFy/25zhjGRKwYU0Q
	 WnhWJ+K6Mnl0Vf1nY6Tty8mCockzLudmx1KF4KgFk50/mg7Ud91EIAN+sWQAQfFSmU
	 iW8vIT7+BWtKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 491258148B;
	Sat, 17 Oct 2026 13:01:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C6CA7F45
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B89AD81352
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f9CLgLdPOJ6s for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 07:39:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EA297812DB
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792222780;
 b=HiXQz4dt6S8yePLHx6QOMhuwmKyb8OzKVjr4EV808V7kpCUKX/NCUwltJiL1hf+aH5Lo
 VGmTJ/4uDvqh8+YlgfrcVLpIClncxPbJhtiWoRGs/T0wO2p5FqFYvHSwajE5k4pOCqu7x
 DxKpcrnlPFV0dNjKsvpr06mcKJI/1R/Fsl3lzR1lEHGFpBjOXghlhD0EaXLu3vneWHNT9
 tBZDA7SO2cqdPb9T9+ZWnw8Lpmgwb3S2gkXLfkJ7YTmpLUHquw7yDB/4og3ylwElmIyr7
 6ZAA+gLnpVo/lzkzkf3K07mMcIESoXMbDFPD1A83HMYYBtOEizJv+dkqmOn5W1uH55w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792222780;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=ix8DI3fhp1FCwHb5OJiPOog0EdUTmBh3EQRFHU9uAlw=;
 b=UCTQWeQOxNyFAvvG8vdKUanBKwSruexRR3fFz9kYz8XprCKAX71gIRsIeemsUc1cFcHW
 6B2VsLk8+Qm+4zpRkIEHM0VJdKbkh2U3M+Vo7b1Yzgwo8f+cScbU6Im5t40/hx4iiF8xC
 ziy22bLs2/rbK8APhfUIUvoOiZ4OwHIAqNLW2Yee9vvxccBTyT+i6SUCcWSDfgkKocX6E
 Tokz1FtrADaXg8R9UqyqXz2t/8Et95U6tMtmxzxU5nLh8CVKsPOh2A8i9hanYOilLXTnN
 3Sazir/hExhU2CtYC9jhba1Fg1n/QmjPvKy/Tx6uERI56HHSG/tQfa3HIC57dvTxt2g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=CUiAIeZN; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=CUiAIeZN
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA297812DB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3AF9A434DA;
 Sat, 17 Oct 2026 07:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1871DC2BCFF;
 Sat, 17 Oct 2026 07:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792222778;
 bh=GnTZkbBuaY1nsYIiBy2mCB7Vptp3TC/Q7JCbaOL1bW4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=CUiAIeZNlVF8ZgXvj2BglKS9OAxT2lNYdj+0/6HirZHME+Y1ubFNLxOqyHF7UfazK
 cPumGRV6TbIz0sxcdDEqCWu0Jyx2MuQvS0Z+QVbghvy5I+4Z3F8A5SKOmt21Y2yuyU
 ubICSyZa1ND0tLkBQClilzfk20/VntxQosatU/udYZhXCENeMCWPmGn7PNNllyAAMe
 vQvbRg8KDBsAlyfmm3tiyZK6kZSRO85pvgU9m4z8NyQYF3dLYRJBdQcTDiIdH4kLDC
 +0rNYo0nYKCWp6jf7YS2ZfK7NVfxxHZwEsH5fbVNv0mNjzx5eJ/6+Pm+mwsBA1Qcll
 RVvasOQnTw3RA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id F22AECC6B2A;
 Sat, 17 Oct 2026 07:39:37 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 09:39:01 +0200
Subject: [PATCH v2 2/6] binman: fit: Add fit,compress for generated fdt images
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-binman-fit-fdt-compression-v2-2-d7e290847543@protonmail.com>
References: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
In-Reply-To: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>, 
 Alexey Charkov <alchark@flipper.net>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792222776; l=5801;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=7FbrXVZt4C9C2kOpsqvK4cKFKYZgImZaeW+ksMMkbcE=;
 b=9OFQpxTfPKCziyiJoG+PcfAbRFM/4BkMOPs1HftCcRzo1reOgOt4dgAnONAZlL30Iinj3TzA4
 GAJvFoZXv/eBXeqQLYH8mpLbcQljct7BYcPYMKuzmj5ilbVscSdi3KW
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 17 Oct 2026 13:01:25 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

The 'compression' property of a FIT image is only metadata.

Add a 'fit,compress' property for generator nodes. It names the
algorithm so binman compresses each .dtb with it and writes
the algorithm to 'compression' in the generated node.

Any algorithm known to Entry.AddBintools() is accepted.

Register the needed bintools in Entry_fit.AddBintools() and
report a missing one in the usual way instead of failing.

Document the property.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 tools/binman/etype/fit.py | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index 4657ed1fd76..a81e3a1de0e 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -274,6 +274,29 @@ class Entry_fit(Entry_section):
     string from the root node of the devicetree, so that things work correctly
     with FIT's configuration-matching algortihm.
 
+    Compressing the FDT images
+    ~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+    The 'compression' property of an image node is copied into the FIT as
+    metadata only. It tells the loader how the data is stored, but binman does
+    not touch the data.
+    For generated FDT nodes, the 'fit,compress' property can be used to ask
+    binman to compress the .dtb as well. The algorithm is written to
+    the 'compression' property of each generated node, so it should
+    not also be given there::
+
+        images {
+            @fdt-SEQ {
+                description = "fdt-NAME";
+                type = "flat_dt";
+                fit,compress = "lzma";
+            };
+        };
+
+    Any algorithm supported by binman can be used (see the 'compress' property
+    of entries) except "xz" which FIT does not define or "none". The matching
+    compression tool must be installed.
+
     Dealing with phases
     ~~~~~~~~~~~~~~~~~~~
 
@@ -746,6 +769,26 @@ class Entry_fit(Entry_section):
 
         return tools.read_file(output_fname)
 
+    def _compress_fdt(self, algo, data):
+        """Compress the data of a generated fdt node
+
+        Args:
+            algo (str): Compression algorithm
+            data (bytes): Data to compress
+
+        Returns:
+            bytes: Compressed data
+
+        Raises:
+            ValueError: if the compression tool is not available
+        """
+        btool = self.fdt_comp_bintools[algo]
+        if not btool.is_present():
+            raise ValueError(
+                f"Cannot compress fdt with '{algo}': tool '{btool.name}' is "
+                f"missing")
+        return btool.compress(data)
+
     def _raise_subnode(self, node, msg):
         """Raise an error with a paticular FIT subnode
 
@@ -883,6 +926,7 @@ class Entry_fit(Entry_section):
                     else:
                         fname = tools.get_input_filename(fdt_fname + '.dtb')
                     fdt_phase = None
+                    compress = 'none'
                     with fsw.add_node(node_name):
                         for pname, prop in node.props.items():
                             if pname == 'fit,firmware':
@@ -902,6 +946,9 @@ class Entry_fit(Entry_section):
                                 fsw.property('compatible', prop.bytes)
                             elif pname == 'fit,fdt-phase':
                                 fdt_phase = fdt_util.GetString(node, pname)
+                            elif pname == 'fit,compress':
+                                compress = fdt_util.GetString(node, pname)
+                                fsw.property_string('compression', compress)
                             elif pname.startswith('fit,'):
                                 self._raise_subnode(
                                     node, f"Unknown directive '{pname}'")
@@ -922,6 +969,8 @@ class Entry_fit(Entry_section):
                                 data = tools.read_file(phase_fname)
                             else:
                                 data = tools.read_file(fname)
+                            if compress != 'none':
+                                data = self._compress_fdt(compress, data)
                             fsw.property('data', data)
 
                         for subnode in node.subnodes:
@@ -1148,10 +1197,28 @@ class Entry_fit(Entry_section):
             entry.SetImagePos(image_pos + self.offset)
 
     def AddBintools(self, btools):
+        # Add the tool for each algorithm requested by a generator node
         super().AddBintools(btools)
         self.mkimage = self.AddBintool(btools, 'mkimage')
         self.fdtgrep = self.AddBintool(btools, 'fdtgrep')
 
+        self.fdt_comp_bintools = {}
+        def _add_comp_bintools(node):
+            for prop in node.props.values():
+                if prop.name == 'fit,compress' and prop.value != 'none':
+                    if prop.value == 'xz':
+                        self._raise_subnode(
+                            node, "fit,compress 'xz' is not a FIT compression")
+                    try:
+                        name = self.get_comp_bintool_name(prop.value)
+                    except ValueError as exc:
+                        self._raise_subnode(node, str(exc))
+                    self.fdt_comp_bintools[prop.value] = self.AddBintool(
+                        btools, name)
+            for subnode in node.subnodes:
+                _add_comp_bintools(subnode)
+        _add_comp_bintools(self._node)
+
     def CheckMissing(self, missing_list):
         # We must use our private entry list for this since generator nodes
         # which are removed from self._entries will otherwise not show up as

-- 
2.55.0


