Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EADCD6E52
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 15:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77FD5838D7;
	Sun, 31 May 2026 17:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="PHTCbCBT";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="WtORmYn1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A06383DA6; Sun, 31 May 2026 17:24:48 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE9E88039B
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 17:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-tb92.prod.antispam.mailspamprotection.com;
 s=arckey; t=1780241085; 
 b=01CJuyWYhKiItHcDFBbLHU66vDzryZGba1yn24PFCp9ttCHcfb46+NarNhz8qRsZL/X7CdAhBC
 DWEXUnsbcIpXJDKhUxp9t5Rwv8HnMmkTd5Ah59iw1GFSe5iGZMkBdIGSlm3UOTlN6wcV5UvPbt
 7vEdgYD6YYMRmyrTLOzH4hNnaPln+ZCqjXAHVBYsD52ewPAIn9MwrcnWMcKAUxeBni38mR8zqD
 ikATyx2EfHw0F9xDQwXO+19J9iC0VmFZILiA4VNlwaHVIYXEI8UstM81Zop0+sT0kbvQhk3bJf
 F5pTYN1oIj3ZHfui3DEHREIzQ/qeOl1LW79yorpUlwAjlA==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-tb92.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-tb92.prod.antispam.mailspamprotection.com;
 s=arckey; t=1780241085; 
 bh=QbnM059VituGR2fvjiXooR5sLYCW5e6YepeKxDg6QJ8=;
 h=Cc:To:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Subject:Date:From:DKIM-Signature:DKIM-Signature;
 b=Cps/1Mb4qFx35nfmy3vYmiHUU8GbI0asv8CLMsHtDjO/bzG/BeoE6M1mVINm0EQeagiW/XL7c3
 g4BdwEB6OO5CL39iZrF6g0fEOVWuAAv3Sv24xsDNSDeSwuMaYXBQQspcPkgffwAe4cHHnDwZ1p
 CcTFJ19PxsZPlDtUopLgkwPtbPzuY2K+v3cVOGDibX6PiN7Vd59ecVHz0MFtCunbcE1On+0M+e
 PWjtV1GbNTWjwBewRDRjAQcWB+H2O99dzc8Q6tyf/gSnrR1q3rcUuRIekheycBtIMe8fpyqO6/
 BVCn9IHW09N60W3Rn3khxcoCANBY6K4BPJ4GLBfds/hCfg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=dz9U7W5s9+cZwfCzVJMHdaTK2pYXzBml48IYOhq2pms=; b=PHTCbCBTxzzi/EYEu3ETMv8Lop
 58C7BiixCw6V2i8yzqrC/w9c23EZS74MnmuIwSN3NvmoJ55mx+Uq6Gvb0rcE4sWwmzTldkh++Atr1
 jb+mTeY1e3Wq6GxGizN/TCiBsAXEYxHUAsHPF9NfZ1f5iYsCm5uMhLH6GWOKeb0RzSKY=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-tb92.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.3)
 (envelope-from <francesco@valla.it>) id 1wTi1q-0000000CUhV-2Wad
 for u-boot@lists.denx.de; Sun, 31 May 2026 15:24:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=dz9U7W5s9+cZwfCzVJMHdaTK2pYXzBml48IYOhq2pms=; b=WtORmYn12wh/MAy55vulzadLQa
 PeviTCFP736dqWXtqd9+Bx4AELVxi2FOVoRxJ2Ke0F7/8IzjAaC/v5HaNYaVf63FdzMAAUoRNAD7K
 adU7WQdCm/w5oKa0BLnYTGTkb5lCJ/w5kzInTTaRmP/BbaD4xb16WlOzaDmwTbQrJxSs=;
Received: from [87.16.13.209] (port=61689 helo=[192.168.178.43])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.3) (envelope-from <francesco@valla.it>)
 id 1wTi1k-00000000BSv-3CQO; Sun, 31 May 2026 15:24:36 +0000
From: Francesco Valla <francesco@valla.it>
Date: Sun, 31 May 2026 17:24:23 +0200
Subject: [PATCH] dtoc: test: add missing escape in help text
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-test_fdt_fix-v1-1-a199c3d2a6cf@valla.it>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU2ND3ZLU4pL4tBQgzqzQNTM0S7IwMEs2MjIwUwJqKShKBQqDjYuOhfC
 LS5OyUpNLQGYo1dYCAGxAV2JwAAAA
X-Change-ID: 20260531-test_fdt_fix-616b806c2206
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2649; i=francesco@valla.it;
 h=from:subject:message-id; bh=QbnM059VituGR2fvjiXooR5sLYCW5e6YepeKxDg6QJ8=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFkyQesmz+5/FnFO8t0tE8vpa3Yd4LHmKerc8NUy8oOKq
 p7DHROJjlIWBjEuBlkxRZaQdTfu7Zlr/i1tA+MjmDmsTCBDGLg4BWAiTzcz/BUT1ZjZ9VJphrxH
 R/S+F3c47mW4qIoEOa2SeeDD/7bOLpqRYf/vjDNruFulr3/TyT6a9NHwRZLBlNxzkyV3PbyxPFT
 7BiMA
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 9a03d558dd489c3152b5753a17af7ca0
X-AntiAbuse: ID - 9a03d558dd489c3152b5753a17af7ca0
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wTi1q-0000000CUhV-2Wad-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-tb92.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

A single percent sign might be interpreted as a string format directive
and shall thus be escaped - doubling it - to actually indicate a
percentage.

Without the escape, pytest fails to run test_fdt.py with the following
error:

  ValueError: Test coverage failure
  fdt code coverage: Traceback (most recent call last):
    File "/usr/lib64/python3.14/argparse.py", line 1748, in _check_help
      formatter._expand_help(action)
      ~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^
    File "/usr/lib64/python3.14/argparse.py", line 676, in _expand_help
      return help_string % params
             ~~~~~~~~~~~~^~~~~~~~
  TypeError: %c requires an int or a unicode character, not dict

  The above exception was the direct cause of the following exception:

  Traceback (most recent call last):
    File "/home/user/u-boot/./tools/dtoc/test_fdt", line 1002, in <module>
      sys.exit(main())
               ~~~~^^
    File "/home/user/u-boot/./tools/dtoc/test_fdt", line 987, in main
      parser.add_argument('-T', '--test-coverage', action='store_true',
      ~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                          default=False,
                          ^^^^^^^^^^^^^^
                          help='run tests and check for 100% coverage')
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    File "/usr/lib64/python3.14/argparse.py", line 1562, in add_argument
      self._check_help(action)
      ~~~~~~~~~~~~~~~~^^^^^^^^
    File "/usr/lib64/python3.14/argparse.py", line 1750, in _check_help
      raise ValueError('badly formed help string') from exc
  ValueError: badly formed help string

Fixes: 7640b166604e ("test_fdt: Convert to use argparse")
Signed-off-by: Francesco Valla <francesco@valla.it>
---
 tools/dtoc/test_fdt.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/dtoc/test_fdt.py b/tools/dtoc/test_fdt.py
index a0bed4e18bb8..f141f931a949 100755
--- a/tools/dtoc/test_fdt.py
+++ b/tools/dtoc/test_fdt.py
@@ -986,7 +986,7 @@ def main():
                         default=False, help='run tests')
     parser.add_argument('-T', '--test-coverage', action='store_true',
                         default=False,
-                        help='run tests and check for 100% coverage')
+                        help='run tests and check for 100%% coverage')
     parser.add_argument('name', nargs='*')
     args = parser.parse_args()
 

---
base-commit: 30b77f6aa146c96b831cb4ece038130b655b6a41
change-id: 20260531-test_fdt_fix-616b806c2206

Best regards,
--  
Francesco Valla <francesco@valla.it>

