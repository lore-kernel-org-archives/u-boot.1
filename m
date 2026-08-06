Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEA4C56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:10:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFFEB607A5;
	Thu,  6 Aug 2026 11:10:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XEwLp_94-3X3; Thu,  6 Aug 2026 11:10:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E68F26070D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014643;
	bh=+vDsIiTP4RJQqVtu/VC5kzoILyXLaYyLkAAXqdfiDSs=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uB9l6F/nt75kfE7Pxe2A8oYkZDADLoC0bGBx9Gcsk4XsDz88dGVicvK9lK/LqRBc0
	 WHqFA6SdFMhqHz1Rt7PXfeYNHSYc5bU6mWdUv588yT/sZObkwRVh/ZLEFHIuL1da5L
	 cKLtXB4rwHUDzubvHJ5YYCSxPA9cX4MMgTGT49lrg7TL/FGZTfpF6Il73cS65g9DPF
	 62E4cCKee4Xzr+uhn6suXTTMGxj37ww9MSydi1USZAT5RvoJQoysOvaTBeI3JVkd96
	 MxdNthR/mG6d6c7rjy65XX4YsVkpP3H+WjVuQuTXsrxurwUf9Tu9UPg7/Z3WEJ7cDE
	 hFJ412bguvBAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E68F26070D;
	Thu,  6 Aug 2026 11:10:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 57D17397
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B69F808E7
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:10:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P2xp3JFYWGbH for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 11:10:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 08FA1808C9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 08FA1808C9
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 08FA1808C9
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 11:10:39 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c160d8760e0so26306766b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 04:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786014638; x=1786619438;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+vDsIiTP4RJQqVtu/VC5kzoILyXLaYyLkAAXqdfiDSs=;
 b=UnsoplHErUDkcz32Q+jWEVzTIfZkUmHgFF2Lw8/xe1GDNJ4t9TbHxSL8n8mAEsuH1A
 dbaeEZXdOycNvRaToUaMzmOFsz51Fd+cLmE9EtjOXbHvDc0Gfj1Br5BDj+MZcejzR2OT
 QAXW8/QFEt9djBYAifM8sY/hxIJVhcYJMjFQNpiEfswozxbMNAz/NPKOIJdaxNjAIGJH
 iu4jTiHcnGpM+KAImZ9aRcwGETbvmVwcrWvVXlrapWrPIwVdBw1QSlFHmAqoLK1Lrqym
 b3UIRPlOIzfhg5APxwSmYg6VmpeynOwxTyN/Xttmf3n7cxzYYEksGEL3APo910m04Sej
 ZLYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro3KPPnD0eMc8cDMVWQIoJYgHxEFj9OFAGpqlRr0DjlW3CH6VdhsWcNQ2HA/o6Zqr09+/1CTvM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyaGwlo7UaS5hWOxfN7rVBQjj4Y1f0JxSUQu1tGkxENYX5ivCx+
 DFMjJZwCUXeXkyhV5hbivxseLMaSXmuoBXG/Xk09poWNJvAxvDjbmJdu
X-Gm-Gg: AR+sD113DH+hcHBs1hz8MM5aDysKQoqWzvI1oM20FM7X1LFVcDaXipI0NzfeUhqttLO
 4UBZGy28KRIbDwAvCKbOkfQnhfDtVogh6SxoBk0vD/C16am1JiBM+2ZK+LAB0Knv7QXz+xPj9hA
 cufN5neyQ3D1GwlPBaklJGAjyWzYREqhjsw5SUGMd/NlLkw6PhGd38IDvYZ38dGn1xHSKpkL9zD
 w5hfS1ajpU/7pkdidPLtyhhZIpi/t3hMmpUkDbbYhrHCegoKE7H6sdX4lUvXmgeXiExV9vtKMrE
 ZskEuaf+GTaUghQCXwTyeaDdjjO2zBOs6BVnKwndp+2/kgqH/w53xeBeZNeB3q4IUnH5iDd2QEk
 FrOsb7mI/RbcWkkH0TlCZGjWBmxv7VXLWVY2bhT+tBURqJYweDTM3dptc34853gr7NqofA0dFDf
 j0DlzdgDH3ia57RKZj4NncEPnPb6hkXz7uFnihsCYz4vhw0Qo3uM55ja1C6tau6I+YLlNKNW2oY
 xoViQ1UBrq/REgYKoLVgNXEaV5E4fZJARSdwA==
X-Received: by 2002:a17:907:f447:b0:c1c:4c2b:8db1 with SMTP id
 a640c23a62f3a-c2039b3a4a4mr433208766b.0.1786014637527; 
 Thu, 06 Aug 2026 04:10:37 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2036274fe9sm232568566b.27.2026.08.06.04.10.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 04:10:36 -0700 (PDT)
Message-ID: <55d2db5b-18bd-4a49-a649-158672fb954e@gmail.com>
Date: Thu, 6 Aug 2026 13:10:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 1/9] rockchip: scripts: remove rkmux.py
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786014638; x=1786619438;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+vDsIiTP4RJQqVtu/VC5kzoILyXLaYyLkAAXqdfiDSs=;
 b=mKeE9ce1ms3gl6EhRtn5wNnIabxViZGkXkQ3IaMNws1Q38Rwre0GszPCVQ8EWeCcGq
 cDOwD0ZPfcdVo63bTMPoCg8LxjgLiSyTqVCDN3T6IZfLI/GzOQPOfSpMxwtS/bG8Jgyd
 nzcwjGYTngdCm9HJL/tALVWzpLAePfYlcz8vMcE+SUEy6wL8avG0U7fFKDOIFCdQknkG
 wiXZdiaD2Qy8cbX8lfu35vCNYwxvelniEAoM99Q5vqMA5ifdCPs8G60Wn0vhwpVxDyaA
 CKX0ZFEbeMIaheq0XCGZWFNIIPMM2jiND64NqxSE+Rv0ON8Sje7gjGsnR5kI14fnzTm1
 W37Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mKeE9ce1
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

It's not U-Boot's core business to host a script
to create enums from datasheets where it's unknown
that it has ever been used for any Rockchip SoCs sold
after rk3288. We don't need it to compile, so remove this
relict from the past.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 MAINTAINERS         |   1 -
 doc/README.rockchip |   7 --
 scripts/pylint.base |   1 -
 tools/rkmux.py      | 218 --------------------------------------------
 4 files changed, 227 deletions(-)
 delete mode 100755 tools/rkmux.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 86ab813aee4b..6dad4875a495 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -538,7 +538,6 @@ F:	drivers/spi/rk_spi.[ch]
 F:	tools/rkcommon.c
 F:	tools/rkcommon.h
 F:	tools/rkimage.c
-F:	tools/rkmux.py
 F:	tools/rksd.c
 F:	tools/rkspi.c
 
diff --git a/doc/README.rockchip b/doc/README.rockchip
index 96fa49d697bc..5a608ed0bce3 100644
--- a/doc/README.rockchip
+++ b/doc/README.rockchip
@@ -651,13 +651,6 @@ SPI flash.
 
 See above for instructions on how to write a SPI image.
 
-rkmux.py
---------
-
-You can use this script to create #defines for SoC register access. See the
-script for usage.
-
-
 Device tree and driver model
 ----------------------------
 
diff --git a/scripts/pylint.base b/scripts/pylint.base
index bc39e2385a31..a0a473b6d998 100644
--- a/scripts/pylint.base
+++ b/scripts/pylint.base
@@ -298,7 +298,6 @@ tools_patman_status 8.52
 tools_patman_test_checkpatch 8.51
 tools_patman_test_settings 8.78
 tools_qconfig 9.79
-tools_rkmux 7.10
 tools_rmboard 8.06
 tools_u_bootlib___init__.py 0.00
 tools_u_bootlib___main__.py 7.78
diff --git a/tools/rkmux.py b/tools/rkmux.py
deleted file mode 100755
index 1226ee201c3b..000000000000
--- a/tools/rkmux.py
+++ /dev/null
@@ -1,218 +0,0 @@
-#!/usr/bin/env python3
-
-# Script to create enums from datasheet register tables
-#
-# Usage:
-#
-# First, create a text file from the datasheet:
-#    pdftotext -layout /path/to/rockchip-3288-trm.pdf /tmp/asc
-#
-# Then use this script to output the #defines for a particular register:
-#    ./tools/rkmux.py GRF_GPIO4C_IOMUX
-#
-# It will create output suitable for putting in a header file, with SHIFT and
-# MASK values for each bitfield in the register.
-#
-# Note: this tool is not perfect and you may need to edit the resulting code.
-# But it should speed up the process.
-
-import csv
-import re
-import sys
-
-tab_to_col = 3
-
-class RegField:
-    def __init__(self, cols=None):
-        if cols:
-            self.bits, self.attr, self.reset_val, self.desc = (
-                [x.strip() for x in cols])
-            self.desc = [self.desc]
-        else:
-            self.bits = ''
-            self.attr = ''
-            self.reset_val = ''
-            self.desc = []
-
-    def Setup(self, cols):
-        self.bits, self.attr, self.reset_val = cols[0:3]
-        if len(cols) > 3:
-            self.desc.append(cols[3])
-
-    def AddDesc(self, desc):
-        self.desc.append(desc)
-
-    def Show(self):
-        print(self)
-        print()
-        self.__init__()
-
-    def __str__(self):
-        return '%s,%s,%s,%s' % (self.bits, self.attr, self.reset_val,
-                                '\n'.join(self.desc))
-
-class Printer:
-    def __init__(self, name):
-        self.first = True
-        self.name = name
-        self.re_sel = re.compile("[1-9]'b([01]+): (.*)")
-
-    def __enter__(self):
-        return self
-
-    def __exit__(self, type, value, traceback):
-        if not self.first:
-            self.output_footer()
-
-    def output_header(self):
-        print('/* %s */' % self.name)
-        print('enum {')
-
-    def output_footer(self):
-        print('};');
-
-    def output_regfield(self, regfield):
-        lines = regfield.desc
-        field = lines[0]
-        #print 'field:', field
-        if field in ['reserved', 'reserve', 'write_enable', 'write_mask']:
-            return
-        if field.endswith('_sel') or field.endswith('_con'):
-            field = field[:-4]
-        elif field.endswith(' iomux'):
-            field = field[:-6]
-        elif field.endswith('_mode') or field.endswith('_mask'):
-            field = field[:-5]
-        #else:
-            #print 'bad field %s' % field
-            #return
-        field = field.upper()
-        if ':' in regfield.bits:
-            bit_high, bit_low = [int(x) for x in regfield.bits.split(':')]
-        else:
-            bit_high = bit_low = int(regfield.bits)
-        bit_width = bit_high - bit_low + 1
-        mask = (1 << bit_width) - 1
-        if self.first:
-            self.first = False
-            self.output_header()
-        else:
-            print()
-        out_enum(field, 'shift', bit_low)
-        out_enum(field, 'mask', mask)
-        next_val = -1
-        #print 'lines: %s', lines
-        for line in lines:
-            m = self.re_sel.match(line)
-            if m:
-                val, enum = int(m.group(1), 2), m.group(2)
-                if enum not in ['reserved', 'reserve']:
-                    out_enum(field, enum, val, val == next_val)
-                    next_val = val + 1
-
-
-def process_file(name, fd):
-    field = RegField()
-    reg = ''
-
-    fields = []
-
-    def add_it(field):
-        if field.bits:
-            if reg == name:
-                fields.append(field)
-            field = RegField()
-        return field
-
-    def is_field_start(line):
-       if '=' in line or '+' in line:
-           return False
-       if (line.startswith('gpio') or line.startswith('peri_') or
-                line.endswith('_sel') or line.endswith('_con')):
-           return True
-       if not ' ' in line: # and '_' in line:
-           return True
-       return False
-
-    for line in fd:
-        line = line.rstrip()
-        if line[:4] in ['GRF_', 'PMU_', 'CRU_']:
-            field = add_it(field)
-            reg = line
-            do_this = name == reg
-        elif not line or not line.startswith(' '):
-            continue
-        line = line.replace('\xe2\x80\x99', "'")
-        leading = len(line) - len(line.lstrip())
-        line = line.lstrip()
-        cols = re.split(' *', line, 3)
-        if leading > 15 or (len(cols) > 3 and is_field_start(cols[3])):
-            if is_field_start(line):
-                field = add_it(field)
-            field.AddDesc(line)
-        else:
-            if cols[0] == 'Bit' or len(cols) < 3:
-                continue
-            #print
-            #print field
-            field = add_it(field)
-            field.Setup(cols)
-    field = add_it(field)
-
-    with Printer(name) as printer:
-        for field in fields:
-            #print field
-            printer.output_regfield(field)
-            #print
-
-def out_enum(field, suffix, value, skip_val=False):
-    str = '%s_%s' % (field.upper(), suffix.upper())
-    if not skip_val:
-        tabs = tab_to_col - len(str) / 8
-        if value > 9:
-            val_str = '%#x' % value
-        else:
-            val_str = '%d' % value
-
-        str += '%s= %s' % ('\t' * tabs, val_str)
-    print('\t%s,' % str)
-
-# Process a CSV file, e.g. from tabula
-def process_csv(name, fd):
-    reader = csv.reader(fd)
-
-    rows = []
-
-    field = RegField()
-    for row in reader:
-        #print field.desc
-        if not row[0]:
-            field.desc.append(row[3])
-            continue
-        if field.bits:
-            if field.bits != 'Bit':
-                rows.append(field)
-        #print row
-        field = RegField(row)
-
-    with Printer(name) as printer:
-        for row in rows:
-            #print field
-            printer.output_regfield(row)
-            #print
-
-fname = sys.argv[1]
-name = sys.argv[2]
-
-# Read output from pdftotext -layout
-if 1:
-    with open(fname, 'r') as fd:
-        process_file(name, fd)
-
-# Use tabula
-# It seems to be better at outputting text for an entire cell in one cell.
-# But it does not always work. E.g. GRF_GPIO7CH_IOMUX.
-# So there is no point in using it.
-if 0:
-    with open(fname, 'r') as fd:
-        process_csv(name, fd)
-- 
2.39.5

