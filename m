Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17B4C5516F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 17:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00FFF60B18;
	Fri, 31 Jul 2026 17:19:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TWyGXQXPDIwV; Fri, 31 Jul 2026 17:19:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 99F7B60B1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785518340;
	bh=IKTGS7xVZC48GOqYpDam5teNot4t9vWEINlNzYvlAKE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yey548Pscrt2Ma/M9xxmnrURNZ5TTzUTUhtGNcCq6PNpZ6dgH8kexIFwkIGR7o7no
	 AqdYBLyiNYmwcXdM2zXfkFY8gV/ojTp/IG48y0LqKaslOtb0fqZrKoLj+mMDw77VQq
	 mvbHlJYDQ4A/uYc6eWC+g/V1XHV4ASGjAoN1a4UY+fF9Ie8RIu9z/XdVyv5uhj63hT
	 co/XxhICsvQBBWkMpU/fyAjTflV0Q+Imu3tFcwxYbQ6aWspHverp7WwWQCF7yi8Od5
	 gBklvHp06rL1noSnmgqQgFdegPLwqnRnJhHO2RfNRWeqJNaBz1faPaxIqiJK2FRQSm
	 iY0tddckr3RxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99F7B60B1B;
	Fri, 31 Jul 2026 17:18:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 25BDE27C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C436410FD
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mcqsivn_gXXa for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 17:11:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CD40840877
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD40840877
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD40840877
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:42 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so1191595f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 10:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785517901; x=1786122701;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IKTGS7xVZC48GOqYpDam5teNot4t9vWEINlNzYvlAKE=;
 b=N7nxSiwueHc2rIzwxc02EnI/4oSdG/xSNHPlPZSJQjhAn4LIIgE0RWBvNscsRRuwlY
 /f6bdmE8y1flYsQ+S6PhZzgYk86l0wJ3dMZoJ+W9gNagzlfAQTZ1ja2qqMs4IfwYfyE/
 taEYZBSTtywHjtjQzVuTiuAJkyb7msOb7z3/llw6PPefuatd7mMfp0E+8PXuBQqqfvud
 zQGuIKQQqpIbKHfetLOiTiVCyKA3GpHigOAzy/Fbr1ulnaurBx0MZaOO+gaqEutjbpQ0
 bVK1Pqn75LdRvQ83lYxugSKDUz4KnvvwQXkRL6rQ2EvEuzeIK5bnbTqBP0ALZShPJ6+a
 T6Gg==
X-Gm-Message-State: AOJu0YygxH3HNqUYpkPZ6MhxnX4koRc0R5CSg8nS27OoHqlhQprsMQUd
 mzsdE1IM3MrQsSYdleB4UtTtMFGLGbQC7Uft/Sx9fXXAW7wBVK4xYmoKHcpMmCI4UVg=
X-Gm-Gg: AR+sD12PgxOfCR8rOV1RwWn48fD2908ChnzrcPD6q1gWT4TbXRG9r+Z1buURc1TJqVe
 MnHM2kaqqEZhtjbdCxboDP6Gg7NFPvRRA2WB/vI5a04O3XvTRAN7akuCzqhpmojwQIsp6G/M7sE
 GW7A11Oyl+BeQ0aXOeuRVzHJjmJr2mSVhszBZOQHxCrbcrMlJ15cHDfldkcU+ZoQJz74KltEpIr
 Dnb63O5pt/6I6O/XGlLUzdFS5cFUvLwDzsFxchla1EFdre4Xk1M6YXSFzhIhFgSkCn8UsSR+nQm
 nmJqCX2Wd/S+ChfBJVCoTDsw3J/+wOHuB6ZvSS6rlbr6BYcgNmbQvR4E49QlCLse/iNq9kGe4Bh
 8m7srif8/hva1v8lCy/JLB508l4C+7RL9F/c+CcBSAWz5IUCYlcxFnyX9tiLH1sVJgKiGpqM8Mj
 FHPWF8F3V/q1nSZXTgLCOpfv26pQPCcDtLpj4tzeZNUnBX0IkuLmRRq3HL/qrOu6bYI4WVmGmXv
 avRB/Gvu5qnx1G7FNLFJT+emWgOxpgCfffuFIeIp5E=
X-Received: by 2002:a05:6000:2999:10b0:47f:815c:2614 with SMTP id
 ffacd0b85a97d-47fd72e0464mr730370f8f.33.1785517900688; 
 Fri, 31 Jul 2026 10:11:40 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d1a58sm7541484f8f.7.2026.07.31.10.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 10:11:40 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 31 Jul 2026 21:10:50 +0400
Subject: [PATCH v2 06/10] binman: Add support for pre-patching FDTs in a
 FIT with a /chosen node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-atf-falcon-v2-6-acb97c172993@flipper.net>
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8120; i=alchark@flipper.net;
 h=from:subject:message-id; bh=v+zJOZYa181uysJU7vlshJHgZKa//NkA8RnLWQcM2GY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTlXFdaKSLuLsYws+sS70Lng10b1vw1Xe6qIGq6bq9h9
 l4uZomZHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz1zlMM/5RuS+xnvM8t0fyBPzX3gOy2yvypWa6Cx16eN5l9gfv+7EsM/2N2PjM
 7/7jZo/KU95LL+XN0srltfiv90b3NlLeruVGFmxEA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Fri, 31 Jul 2026 17:18:49 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785517901; x=1786122701;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IKTGS7xVZC48GOqYpDam5teNot4t9vWEINlNzYvlAKE=;
 b=v9vyrGOZJOwIH3l21VRJzQuP/nVHslWlIL54Fc3LtuO+5dZvnUHMgcXMGftvK+g6uD
 CKD0lD0ryaaBGcOjEunJAfXFskBf1KlYwwLM2IfgPk7lDKcGWPQTkVDEclbtVohJZSqv
 s6yCAwdnY87Nx6ZV/9WlAC6JRelznW2NeHPo39cnXbpitEOkVe9bAZ6EAQsEGF7VdYib
 m4fcI5BYc97RJhu2v+f/USP9WivfGUiAeXWSW2msq4tuPpvLy+1bbkDMavgLq/mHkHLp
 PaIuu7Lvwup2aEJr6V3jpzOjnzLmRJyPYjAygLhVejggPsqkqG+Cs8+thWUJTGBl5Ga7
 bKng==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=v9vyrGOZ
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

When a generated FIT is used to boot Linux directly, bypassing U-Boot
proper (Falcon mode), there is no runtime code to discover the kernel
command line and (optional) initrd location and include them in a FDT.

To facilitate easier preparation of a ready-to-boot FIT, add support for
pre-patching the FDTs in a FIT with a preconfigured /chosen node including
the bootargs and initrd location.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 tools/binman/entry.py     |   8 ++++
 tools/binman/etype/fit.py | 103 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index ce7ef28e94b1..e0dea8bf3a49 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -636,6 +636,14 @@ class Entry(object):
         self.Detail('GetData: size %s' % to_hex_size(self.data))
         return self.data
 
+    def GetNode(self):
+        """Get the devicetree node which describes this entry
+
+        Returns:
+            Node: Node for this entry
+        """
+        return self._node
+
     def GetPaddedData(self, data=None):
         """Get the data for an entry including any padding
 
diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index 32caa03a7e16..750ff5b47ed5 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -304,6 +304,40 @@ class Entry_fit(Entry_section):
 
     See :ref:`fdtgrep_filter` for more information.
 
+    Patching /chosen into the generated device trees
+    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+    When the OS is booted directly from this FIT (e.g. Falcon mode) U-Boot
+    proper never runs, so its usual runtime /chosen fixups do not happen. Two
+    optional properties on the `@fdt-SEQ` node make binman patch each generated
+    device tree at build time:
+
+    fit,bootargs
+        A string written to /chosen/bootargs of every generated device tree
+        (any existing value is overwritten). Typically set to `CONFIG_BOOTARGS`
+        via the preprocessed devicetree source.
+
+    fit,initrd
+        The image name of a loadable (e.g. "ramdisk") to use as the initramfs.
+        Its `load` address and packed size are written to
+        /chosen/linux,initrd-start and /chosen/linux,initrd-end (at the width of
+        the device tree's root #address-cells) and reserved in the FDT
+        memory-reservation map, mirroring fdt_initrd(). If the referenced image
+        is absent or empty (e.g. an optional initramfs that was not supplied)
+        the initrd properties are omitted.
+
+    For example::
+
+        images {
+            @fdt-SEQ {
+                description = "fdt-NAME";
+                type = "flat_dt";
+                compression = "none";
+                fit,bootargs = "console=ttyS2,1500000 root=/dev/mmcblk0p2";
+                fit,initrd = "ramdisk";
+            };
+        };
+
     Generating nodes from an ELF file (split-elf)
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -749,6 +783,66 @@ class Entry_fit(Entry_section):
         return self.fdtgrep.create_for_phase(infile, phase, outfile,
                                              self._remove_props)
 
+    def _patch_fdt_chosen(self, data, bootargs, initrd_name):
+        """Patch /chosen (bootargs and initrd) into an embedded FDT
+
+        This writes a kernel command line and/or initramfs location into the
+        /chosen node of a device tree that binman is about to embed in the FIT.
+        It is used for Falcon-mode images, where U-Boot proper never runs to
+        perform these fixups itself.
+
+        Args:
+            data (bytes): Device-tree contents to patch
+            bootargs (str or None): Command line to store in /chosen/bootargs,
+                or None to leave the command line unchanged
+            initrd_name (str or None): Image name of the loadable to use as the
+                initramfs. Its 'load' address and packed size are written to
+                /chosen/linux,initrd-start and /chosen/linux,initrd-end (at the
+                width of the DTB's root #address-cells) and reserved in the FDT
+                memory-reservation map, mirroring fdt_initrd(). Ignored when the
+                referenced image is absent or empty, or when None.
+
+        Returns:
+            bytes: The patched device-tree contents
+
+        Raises:
+            ValueError: the referenced image has data but no 'load' address
+        """
+        fdt = libfdt.Fdt(bytearray(data))
+        fdt.resize(fdt.totalsize() + 1024 + (len(bootargs) if bootargs else 0))
+
+        chosen = fdt.path_offset('/chosen', libfdt.QUIET_NOTFOUND)
+        if chosen == -libfdt.FDT_ERR_NOTFOUND:
+            chosen = fdt.add_subnode(0, 'chosen')
+
+        if bootargs:
+            fdt.setprop_str(chosen, 'bootargs', bootargs)
+
+        if initrd_name:
+            entry = self._priv_entries.get(initrd_name)
+            initrd = entry.GetData(required=False) if entry else None
+            size = len(initrd) if initrd else 0
+            if size:
+                start = fdt_util.GetInt(entry.GetNode(), 'load')
+                if start is None:
+                    self.Raise(f"fit,initrd image '{initrd_name}' has no "
+                               "'load' address")
+                end = start + size
+                # Use the device tree's root #address-cells for the width, as
+                # fdt_initrd() does (4 bytes per cell)
+                cells = 4 * libfdt.check_err(
+                    libfdt.fdt_address_cells(fdt._fdt, 0))
+                fdt.setprop(chosen, 'linux,initrd-start',
+                            start.to_bytes(cells, 'big'))
+                fdt.setprop(chosen, 'linux,initrd-end',
+                            end.to_bytes(cells, 'big'))
+                # Reserve the initramfs region so the kernel does not reuse it
+                libfdt.check_err(
+                    libfdt.fdt_add_mem_rsv(fdt._fdt, start, size))
+
+        fdt.pack()
+        return bytes(fdt.as_bytearray()[:fdt.totalsize()])
+
     def _build_input(self):
         """Finish the FIT by adding the 'data' properties to it
 
@@ -857,6 +951,8 @@ class Entry_fit(Entry_section):
                     else:
                         fname = tools.get_input_filename(fdt_fname + '.dtb')
                     fdt_phase = None
+                    bootargs = None
+                    initrd_name = None
                     with fsw.add_node(node_name):
                         for pname, prop in node.props.items():
                             if pname == 'fit,firmware':
@@ -876,6 +972,10 @@ class Entry_fit(Entry_section):
                                 fsw.property('compatible', prop.bytes)
                             elif pname == 'fit,fdt-phase':
                                 fdt_phase = fdt_util.GetString(node, pname)
+                            elif pname == 'fit,bootargs':
+                                bootargs = fdt_util.GetString(node, pname)
+                            elif pname == 'fit,initrd':
+                                initrd_name = fdt_util.GetString(node, pname)
                             elif pname.startswith('fit,'):
                                 self._raise_subnode(
                                     node, f"Unknown directive '{pname}'")
@@ -896,6 +996,9 @@ class Entry_fit(Entry_section):
                                 data = tools.read_file(phase_fname)
                             else:
                                 data = tools.read_file(fname)
+                            if bootargs is not None or initrd_name is not None:
+                                data = self._patch_fdt_chosen(data, bootargs,
+                                                              initrd_name)
                             fsw.property('data', data)
 
                         for subnode in node.subnodes:

-- 
2.54.0

