Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB0DC54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 06:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 847DB60825;
	Tue, 28 Jul 2026 06:53:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4qP6PLmHogfO; Tue, 28 Jul 2026 06:53:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D8E96081B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785221626;
	bh=4eDx0AAxAPJJM+DV4iJk1DZqEPatMBg1qvPdkKvOq8E=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SJuVTyOFTK6TtGDS/Vx+X+lt6u/VCTifgmi6uvX0/Wuw/JbI95oQriAvt9+F6itC8
	 0msrP0BK2Tnp49HaSEl1VIP5P/iGhDHPy5CWd1btTJosE4PtFLElTLgtW7sGkUNXHA
	 JW4uPUJ6quPv86WwkEGzFOe3/tSH8RO6IrL1t9cYDSu5RFs1625hXh9yBkRmVRlPAS
	 6u1mEBHYQeamhF4DgffrlrEm5rjxYXfITG3kAzLTqTJaQx6OtjFli4fPmlv35osonQ
	 o11RepuP/dc0XqIqqc1SfVF1RNWdUy2TmuJmfRaR4K+Kph/cSxz4iYC8cGOOAIlf6X
	 0fIeox4+rJYwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D8E96081B;
	Tue, 28 Jul 2026 06:53:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FD8726C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 61C6940245
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:53:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pku7w-2ciR4i for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:53:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 409E140042
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 409E140042
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 409E140042
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:53:44 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-698af3e3620so99274a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785221622; x=1785826422;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4eDx0AAxAPJJM+DV4iJk1DZqEPatMBg1qvPdkKvOq8E=;
 b=nRAa/0ovTB9gEiPVJirAAtF6QgxCmVvr7lUnTZotJBEJLMMJ+tzeCbCihKWmXwsZOT
 KtZhAtRjUjF3Wq0wBoqUt2nGlgeIIyQ/+6POfNSnpuDoJxBLwIudM+IuTiOWM5buqEYd
 IFX9nI/80hub8a6DYWLQ/ckLuYmYxB7lhGIilDP9OxaOe2GkN/GeH2Pak7ctIvfCcQeB
 hb7kwx0zE3gIgIu2HtQqbQuZNX5e1ud10d65oo45/9diz+7eK/qbqrGM4bOdjlJd5VrS
 z9GnpgYRUoGbxK+BVq5h8Z8c8DMkrX6bmuTGY/uU1zOtWt7t6R1fv1X3x88Z4zSQjAVC
 hcmg==
X-Forwarded-Encrypted: i=1;
 AHgh+RomVhM3j8zevrXo5MNcunh1MIZMKb+Q8ltfBv4T8sMfrbh0Uxd8wri5qRGQKaR1HuLJj67gCYU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwpWufKGZtJkkUhCn/Ls76dhEFShfW8lqWhdrTD0leyRinu65Bq
 Oy5JA1K16G4ksw1lKs++6TyNShJQ4xAtzI+jPkEsBbIlLdlD7KbbZAzd
X-Gm-Gg: AR+sD12HZQG5obU2UvQ3PMosK4SN+NqjNOjuSeShtKCqd8Ud7qc/BRwwVtHRrf77LJU
 pX4N1KRhawp60AhSvfWRp5DKD2muDGN2Iwt1p3wSuneOS2QTUBAeJNBEV1vtgegCsnSQY2NmZwV
 7SMGJpyTSO+BXWayee2+cAiDf2thC+VjEl+xDMq8cFs9PBqtf2FM0lDq7HDc3uBOrWJiR4P/zae
 unCstlrjUSlnFaXD4vJbEfp3IrpdcqFTaEkwN9Rv8jL1uoEt9ffWEExVtA6DcDHcZ8/p/BgtpTt
 c9AF2uiwsL48G1MfwXm5wgxiVyzASiG7X4wE+WrIvNHaMvQLA//s30Ce1A1pIpZi2G+1Ha3h03a
 CiBSnZc2aQakdwaiPgF7P9EYYmKWqeXhU3ZlkQ+5ZN7yVkzXeCwwKkDorWaibXrxUQK9toMDeIK
 wc8Az0HeX9A87ffAgQawTszSBmJJAhMwk96/ZpvGjU
X-Received: by 2002:a17:907:5cc:b0:beb:3449:5fff with SMTP id
 a640c23a62f3a-c1f716afb5bmr52190266b.0.1785221621898; 
 Mon, 27 Jul 2026 23:53:41 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32f19c4csm717659566b.63.2026.07.27.23.53.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 23:53:41 -0700 (PDT)
Message-ID: <f7ed1756-6018-4b11-8170-7e6b363295b3@gmail.com>
Date: Tue, 28 Jul 2026 08:53:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 01/11] rockchip: scripts: remove rkmux.py
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785221622; x=1785826422;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4eDx0AAxAPJJM+DV4iJk1DZqEPatMBg1qvPdkKvOq8E=;
 b=pZ/HxEXzyLjtGJDGC9oqMslqFSKnVQmHGu4LzSLjZzImMhY0snfH1BcietZK793C2M
 46tS81QOShUMp2Hlvb7Dsn6UNccOJYnKgZ1P73Id58KU72eD16et6U6fqswsQ4eoUkYw
 f1I7nzCw6pNRQLKBzlnWaaUQ4taYHgcuOduzMAdMg9mrmJhWitdw4E3QFyEM0qvbGHOs
 Gg5PzHzCBnYNIedJI0Lo87Bb81bnzAxkR7kbm99YDV0TlsCgx4265OMRvRAtlZdMOSYO
 Hk2UpnqLOl0BHiTyQD1hXKZC2FFz8yFfw2kNlqbSNxdTOw2NEwM98jwHIUUd005ySig5
 nEBg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pZ/HxEXz
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
---
 MAINTAINERS         |   1 -
 doc/README.rockchip |   7 --
 scripts/pylint.base |   1 -
 tools/rkmux.py      | 218 --------------------------------------------
 4 files changed, 227 deletions(-)
 delete mode 100755 tools/rkmux.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 53034b703df8..9660706ad5e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -547,7 +547,6 @@ F:	drivers/spi/rk_spi.[ch]
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

