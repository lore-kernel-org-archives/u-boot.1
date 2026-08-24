Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF76C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 271A640699;
	Mon, 24 Aug 2026 13:13:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jlF7vSsG4BdG; Mon, 24 Aug 2026 13:13:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577215;
	bh=uTeMBhHfljwInRlL50C9SJsfnIGKMa1C59o4uz3qSFo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wTG7ogLVljVhduoH1nM/fOC5v3adUMUfy+xlPYRsDoLmmv+/3yRDHVv3RnYILkEOc
	 DFT2/zzp/cY3gexPm0VDSSdo9M5Pm8Q8liuz+u8tNywb5UWspgrWbEHK9mt80eEFYA
	 z7k9B70A1NgieYHupF2xNg8/hT6244XvLTnSTU5b3GSh3TT7RFHjaRJ81PyAP2oNnf
	 5iwLQkGY3p+cto4+GaqBTGy/VXxpH+M4piptYXs0oiz450pBKLH6P+OChWH9Xw2k/N
	 cJXRAk1GOvRli73ZRtVt1O0ttPe4e7EBmJ3Aq1TUJjHkuKuKpwzc+/DA0oxuOXvceU
	 INnntgeMdYKxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2727E406D2;
	Mon, 24 Aug 2026 13:13:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 14DA2396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EFA6D40029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tdfEyb1iDg2C for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:13:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=la11vbE2
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1A0DE40050
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:31 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49557167508so13199385e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787577210; x=1788182010;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uTeMBhHfljwInRlL50C9SJsfnIGKMa1C59o4uz3qSFo=;
 b=la11vbE2SrNOI5G9DxGs+j6DJR6cvqIehcPcOnEpQ0gScP4CPENiTRNbfy+uXHsdp5
 CJJYqXWFqrfpMHudJGiIlb4mAqMHhd2hjqxAeFinTQuSatZLn2BKeEQ+oGK3cJsF2Toc
 Ebdk57Nr5AVOY1GEE3aKvhj3waI+o0jNgIJ77l/2wATGzn4sTrkQ5dIMYWeSX+qDt8tl
 +Cc2qyiQd63aRxONtdQx0wu2pGtNTsaGcsuZH/6W7nPIbb0oPGuS2tf3VvRwbIEAJbpw
 TcDt/3ZL8Q0QkPIRad8EnjiKn4Vw+viUK+2ZEWbhA8l4ks0mN7GFzOkedZ4Jdrs33dOd
 eVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577210; x=1788182010;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uTeMBhHfljwInRlL50C9SJsfnIGKMa1C59o4uz3qSFo=;
 b=KxZ/vGx9UA0mC95rPJFPJtNBQqEd/Q3xPonZUlD5JTuR0ZpfLqJdFR23gt5BdAcp4Z
 UQoVF5QHQ5BS5cnWatKsArgJpRhNYnWqVUD1CFNs85GtEz/942Zq1pq3ZJ0FJQmGGyQJ
 9gt4XfhOEEMYyDuBi7/I+a7KOTexJxsHPAVaZfxnSE2g0zxFen3W+MxEG6EKEzvtetTA
 cL/mjRCN6EUuEB22fSJfTk3ZzHjj/bug0p9MTo731P78ra9X8pXsQD4EMOzsjir0SQ5V
 xspIojVdkg44q1LWgupDw89k4xKcJvCfN0GQ/DzH7pKuogEyVBw+AZJv7bdLlCfJr15N
 Tyqg==
X-Gm-Message-State: AFuF++mYgNLUPf07r2CzU56CHJw7m9Wt7Fb+kvjeP/M4gjC7afXaCs//
 3rvXxirKsMrvT6G4GiOxUuERdm9EjLvlUHK9OkGHfHzCn9+VdwVzSPFg2FNqGmnqXd8=
X-Gm-Gg: AR+sD11JQhC0GHQWwaWC3RopwROb+SDjkRNWWJHyi5HH03+U8hfinYZBvwzUWRt8E9B
 JW7jLaBJU/ahHZRnWMdGzR4KZKObaDfGdvPP99njWYL3POX43SlCeRn7ucibEDlH6KSH+3Fxrtv
 t4bOz5pAJAWNLZ4xiV4PUTkUmhcOIeUwvQC+KDkmV5GvOEd0Dgr5sfiXoR5rMYw8vEoZAWpjxCf
 /S7B41PvosJeIMwV9Oa6unQGkCkh1QMkgh89G+XOC/DJ6x6vlCitBN5Fw86iwt/4zdTDj9Zzz4f
 9N1fGarq4f28KjImwwFWh3QzglYTbCbB2Zm/RcztYqaTnRImMuIPjW7k5WkUOQMZn1Wm6encJGW
 1FRhxwakpwrztJSDS4ESWhallRrlTEi2XgI1kJdmEXdeG0qRxL0CgkR98UkrYnb6f0fn2AqCa3o
 MpADouQYuTyM5zA/emeMH/ZNHN6BzG1GOFk6F+Sk/HA3ScWREcmPHLEDuZQ1A0X0Fol/RH/k+Em
 stJDTjvoNReHObuYLJS4Kgh1/CSxUSvjMqfDDZTl2m+qLM=
X-Received: by 2002:a05:600c:46cb:b0:499:a277:e8b5 with SMTP id
 5b1f17b1804b1-499b82d2865mr306580065e9.3.1787577209665; 
 Mon, 24 Aug 2026 06:13:29 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b85412sm8144059f8f.14.2026.08.24.06.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:13:29 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 24 Aug 2026 17:13:03 +0400
Subject: [PATCH 06/17] pylibfdt: Add FdtRo.get_path()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-pylibfdt-sync-v1-6-a42be6fa4872@flipper.net>
References: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
In-Reply-To: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Luca Weiss <luca@z3ntu.xyz>, 
 Brandon Maier <brandon.maier@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Simon Glass <sjg@chromium.org>, 
 Rob Herring <robh@kernel.org>, Jaipaul Cheernam <jaipaul.cheernam@est.tech>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1971; i=alchark@flipper.net;
 h=from:subject:message-id; bh=SUc76XAYJyh88HuU7feOG83j1K2oRWmd+oEynAEqQYg=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1OGfpn/toWzE/+0uu8YO95213O2/YwlK8Q4jJbPUNJ
 qviN+xpHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz1yUcMf8Xf3UnWXiDDk9dvYTlHmpH14buJVoZ7nI1CjFUv1HuWFjP8d0r7vnp
 ncKXFhu5ZDE/dCwLeLjxU8nFfzlLnuu8vVbcE8QMA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

From: Luca Weiss <luca@z3ntu.xyz>

Add a new Python method wrapping fdt_get_path() from the C API.

This is a backport of dtc commit ed310803ea89 ("pylibfdt: add
FdtRo.get_path()"), without the dtc-side test, which has no counterpart
in U-Boot's test suite.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
[adapted to U-Boot]
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 scripts/dtc/pylibfdt/libfdt.i_shipped | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
index 735a3bab6d9f..634ccd2a829a 100644
--- a/scripts/dtc/pylibfdt/libfdt.i_shipped
+++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
@@ -447,6 +447,29 @@ class FdtRo(object):
         """
         return fdt_get_alias(self._fdt, name)
 
+    def get_path(self, nodeoffset, quiet=()):
+        """Get the full path of a node
+
+        Args:
+            nodeoffset: Node offset to check
+
+        Returns:
+            Full path to the node
+
+        Raises:
+            FdtException if an error occurs
+        """
+        size = 1024
+        while True:
+            ret, path = fdt_get_path(self._fdt, nodeoffset, size)
+            if ret == -NOSPACE:
+                size = size * 2
+                continue
+            err = check_err(ret, quiet)
+            if err:
+                return err
+            return path
+
     def parent_offset(self, nodeoffset, quiet=()):
         """Get the offset of a node's parent
 
@@ -1120,6 +1143,11 @@ typedef uint32_t fdt32_t;
         }
 }
 
+%include "cstring.i"
+
+%cstring_output_maxsize(char *buf, int buflen);
+int fdt_get_path(const void *fdt, int nodeoffset, char *buf, int buflen);
+
 /* We have both struct fdt_property and a function fdt_property() */
 %warnfilter(302) fdt_property;
 

-- 
2.54.0

