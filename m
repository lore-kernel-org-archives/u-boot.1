Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F59BC55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5961C6069C;
	Mon,  3 Aug 2026 19:11:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VRkTabM8Ayt9; Mon,  3 Aug 2026 19:11:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 542A76069D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785784301;
	bh=+vDsIiTP4RJQqVtu/VC5kzoILyXLaYyLkAAXqdfiDSs=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MR1IfLeb4LlmfWu+v8/h4OAhnxO7Z2HvMGFCGR3gpBlMiFkh+OBBlIJRB2dBgzO56
	 R5VLNxxGzccoqdwGiUfeRFPLrnVUhvjDEtLjSTSA4jv0Rgdp76KdeQJnVAMeiDbaE9
	 66qbo4Rp7WXnUxxybuKiYkAXTe4eFl6SVB87ThEH6m+KRFB28xI0J46WAo3NQlHpgg
	 VydviQcUhDhAvo8XsFPrB6lQaL7TX7oQ5WsUQ7ScL5Ds8OIsfZQ8qIDuRwPgYHGX8y
	 IaKW93rX74KfJJs4DGJyVum8agFuWGt1Wi9Frw3CwNt/ErZrrwtrBnTc4R3aOy2kY0
	 USySwesomsgHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 542A76069D;
	Mon,  3 Aug 2026 19:11:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 590A32CE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:11:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3EDB44015A
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:11:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pxzLwKHcsIqd for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:11:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1CC9D4005A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1CC9D4005A
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1CC9D4005A
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:11:37 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c15df0c154dso48101766b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 12:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785784296; x=1786389096;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+vDsIiTP4RJQqVtu/VC5kzoILyXLaYyLkAAXqdfiDSs=;
 b=seTFJEgBZaexwSXBDvJJRjsfAZWop6XiAkgMBy7VMBXpLB8JEG4lW08flIRCCDFIUL
 k4F/ldeRLhRhhd/C8z4IHf31aV9fpiD6XoNxRryNR7RmB04oyojGAwioWEPIWpyXAq+5
 YDNw27h7/iqjJcXEvRAJU6Jvh3k1q7MgXWpIgdVyhnYNFnnFrprNlEYg+VZCnxVgWDCz
 KhLg+kVyI/PcJp6C8us90/KY0GJrtjSNC3lL6zEmCBrx9FKYDbYcKj6WluNhpjZ0qC+K
 6e8r/piSojVFbBw3H+zxifY3h9jTIXnOBsWKb9ZFFPYR9kd2L5iDj3CrNV497AY/Eqlv
 qv8g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9A1zGv3RFTqJuiWDu0CvF4/HpKaUDZxzYOXAcSeoICWVaq7byBnvxXeUNcMW/8zJPNtmkrKA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yww+OnUenF3wMizqsNiOtOWcPzqRK7B28AvY6AhlNx9OmBWO5eb
 F/ThSKBbpuPmVkqZCsJ13tzvjQhiCHIkfR5XaH1vshfNG6m3kXyZ+h8k
X-Gm-Gg: AR+sD124F6EBh5czjUgsG5O4KsP/+9GFA7BBzXjMkuURb5DzMnHnIAlFUC7z7R0pL9a
 b/x7O9t6y3pB54sx9IHpTYDrpxHxbn2FM5I2yHP5Wc73kLPQuEsckQVq0AzRzjaCfzi9e9MmvLs
 y+x/jq3G8HRKRxjMwXaE1GwcYod+LPd/TRxZK5tCbDBeVCKwoecyu7JZ54UCSBQpG1xGpWPTa1n
 dg1BSjlzSlxwpu7v2PRh7W7ZPjW5Tnyf0zh5iCuifQTxTJqPjunTbyS7jbfuCIMzLTrx8fng/WO
 W0O5BS1HZUmPT8iUkzfEveQHm36M7yLe3RIoEaCUQKQLIBj/LRNQVX8466kzrV8Us2F5Fkccmx7
 7b0iPkMvswviHPl7oQqytGtzC18SXNNVCtwuBpwuPD0vVO0kL7NF77J7u7QuEDOz5LanhlcJsuj
 xxshUFcyvgEVf2RFpf/nz7wqwjXFHps+uBP7qtkfzR5L5obPDQ4FceSdyoLvy9xKv/hty6uJkAn
 FutX6XRWzNbLdMqAl+MEhk4CZU=
X-Received: by 2002:a17:907:7249:b0:c15:c651:f28f with SMTP id
 a640c23a62f3a-c1fe8171f78mr661567766b.3.1785784295962; 
 Mon, 03 Aug 2026 12:11:35 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd4454472sm582668966b.34.2026.08.03.12.11.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 12:11:35 -0700 (PDT)
Message-ID: <d3b88153-9503-4d2b-ae6b-4634a652c238@gmail.com>
Date: Mon, 3 Aug 2026 21:11:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 1/9] rockchip: scripts: remove rkmux.py
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785784296; x=1786389096;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+vDsIiTP4RJQqVtu/VC5kzoILyXLaYyLkAAXqdfiDSs=;
 b=ScJjKoOEckWvKnWKh3FPl5w0qy9qzVfFa5vaHFYPbSq21cCkWo1Vy42rG8Fu6n+8XX
 t01wqy8EBmbt3+OKGaNnWoZ6gTbqr5xuhCks/Jj+z6PQjTlP8mEIziV9HZnY7Kiogv7d
 s2oH1EZ2GHcfsi/NRrYaNK7wyUeOzgFOqhccUEO40WQNkWKNKAgaSunDGR8SG+Ft3bam
 prdjTsiTBY6+uHLUpVokd45mcSlYf7TLXlvkCh0DuWmMuqcrCZFZRATykjQh9XflDnDY
 TuH0wlm2fXqnGo39hR35BiolGWRveSEeRLCJ3doENiSXGdrtH0C1i6dA3dQQ4AnBiEq5
 n8dQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ScJjKoOE
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

