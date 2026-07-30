Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B4EC55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:32:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3FD380F91;
	Thu, 30 Jul 2026 13:32:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uiiC2U2hC0wk; Thu, 30 Jul 2026 13:32:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1564980F88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785418330;
	bh=aaCijGD4ZIZjPR5WzptKKU+x4Hirkg3FLzD7/SGPdSE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aTy5+0vKMwysz6a+WI2zATEr2hcChx6uihw6eifOghvllBsnUPd787v5Gej3BQt3u
	 IxXAXDnY4JHm8pZ0BvfavtAIPnhZsCyGqC4icLtp9lUvVpc6cPw3yuXWsVyB/rpmn4
	 NyKdcXexkj0SwPxxTw04qgFF9EAdhhGrFsbMRPM5lrDLGuxna8wfeYH03a28kgNNq8
	 cMLxOo2o0l2KytUcpCAK/Sx+lkivz0fvQz6GnjEh3OikXygGhMH7STKDHIoKLuTlea
	 Vd4QsZybzvFUVoA6+bJczeB6nXHiqt4PuX1Xi82JSnmruUoVNDOMXsvlNXZGfrXyum
	 g/JekRs4ebpnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1564980F88;
	Thu, 30 Jul 2026 13:32:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DBA34197
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:32:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D930F80F2C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:32:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3-wwxqGFltOO for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:32:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 993D380DE7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 993D380DE7
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 993D380DE7
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:32:07 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-69c3044e4b2so347068a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418325; x=1786023125;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aaCijGD4ZIZjPR5WzptKKU+x4Hirkg3FLzD7/SGPdSE=;
 b=n8qRngq9S9OH+fgJHV3MpU2eW6rU2Ld5oNCvwWE63C3Yu73h+conolcQTr0lR07hc4
 wldevq96yz4/B4vNzawNIQ2+zjjnj9bGP/tfPp7kAoXIhjNEwM92DJBLt1a/aQx3vQyL
 l1r9bIdsX+0lNT5jTqwSMGchrAze2SjmNlNcwcaCGjxv/W4qid+4Ex+7dIPezivqFb8/
 We6Y8F2/sYd4e39IGGZavRw8TuBha77HP9921i6DqiobSSvD32l0VUGnXh5ZwD0XvPon
 8guilKArU2agpZv3GjDkstcjkkJYbRYBo3Xq1UB2HIeBdntSH5wTDqvH4GHYLTsdodaU
 A8Sg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBP6oCOU/+y3QgihMjAuU1bBriDWa2Vm2vIcUqF6Vywk7EvuU7UMyD2n+faJvULQhSRt0gQnw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx2Eb4wjpKbxbz5gB7PamPQbGB2REQkX93t+Oftuvp6mxOpmIkD
 2MxgrFyRJl3F5LPx5GC9SxtzGjDo+fDT4iUa5M8AH9Y9zWEp21Pgxoc5
X-Gm-Gg: AR+sD10xOCi7dr5ECF1t8/bqlf0Q+e+Ddy89PE24WN9EK6GZLsMrkMqz1jZG8PGEyN1
 ehsQVIIwBm47nmVHRrG5SKnEUrZQML703VUGX0Cr6McDoGG3X0yfTZuHuEEm9/+GbN741Pr4DPy
 a0e6fJAkDPy7OKBNyIQJf/vmCkLElNgImw6NinXlO16G7u37JcW2nwJ5SBJX89bVnklJ49nn9GE
 Tib75vqKsC/ppdlqTkzfsPdX3yn/IQ8ZEUYLdMSL4LbdMfbPxFAJmkG6BYFqZ1auBkOtWCP5DSw
 wYpycBxtcQQwqlcIlmOFom79UZleZ41bGfFL3P7+Jlf19nzxlDUJqGDwoR9xzYnEnSdQgGXv5WW
 Yw8Dvd80cr4knlsPd+QkiLOK5FX+K0SVWq7VfzGFhUNGN1J9dv/8WPGEBAz3rYl9kedZ5m6VeC4
 KV2B9ywhYPMh3dp5bqOdphrmRV/PPhKjXqEIXz7T+vZNfQFb5/JAF4MqHVJxOEXkVRberg/r+zH
 lGsdTHMZwJqNS1z/HcqK4pYo94=
X-Received: by 2002:a05:6402:1ed0:b0:6a0:5294:d1a7 with SMTP id
 4fb4d7f45d1cf-6a090d3b53cmr196026a12.2.1785418325048; 
 Thu, 30 Jul 2026 06:32:05 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a07ca7046bsm591904a12.11.2026.07.30.06.32.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 06:32:04 -0700 (PDT)
Message-ID: <29151ea2-7e8b-40f7-bf22-e487def1445f@gmail.com>
Date: Thu, 30 Jul 2026 15:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 01/12] rockchip: scripts: remove rkmux.py
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785418325; x=1786023125;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aaCijGD4ZIZjPR5WzptKKU+x4Hirkg3FLzD7/SGPdSE=;
 b=ZlWIJs2glWzY30mrCy4ED5UgjvJEVYb4nKSEYYumdKnPZzPxTeXQMHv3SmwJlIvqFH
 +Il8wOdBZJkTii3/ANBSmE/N4QA8wGRlYGQufRc+0AWpOnlfl/PerBVcTGWV0lg2oXrf
 ENYiEDbPKkMELXGvj6kYGHqme/RVUQWZTxA5CYNymekqlLA383RL199Ii8P0/DeUE3Pw
 huj+lQaPSnefwFbqL8jqwqYyeBeBWTMhnf1yEx2oQnY0E6mmj1Xu7DKuI+PRT2AkKnT1
 QDhDMJ2b7c+JquQZJD+VJQEsfRUiQquPhNoTv18ddfU/asjHuN4+2qCNaiuSfRHBva8w
 pgew==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ZlWIJs2g
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

