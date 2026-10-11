Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5E9CA9ED0
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 17:23:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58A3260689;
	Sun, 11 Oct 2026 17:23:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fVv62UMfYEXB; Sun, 11 Oct 2026 17:23:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 38E626067C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791739394;
	b=p5ZAPiAo6NPyBd/bdWv6FBwRKbaIl1ITuwcrp6bj+EvOCms4ivrb7Uh655EJi0FokvpG
	 6ewTP4awmqoXnJC3DyoU26+ujcPqacLesN+2r00xFu+0Magl3XEQj+uR7Z80c25/0IoZT
	 mC4zLG4taaYnUgv4CTVjj5kXooNW8VH4EZWrF8n3BA4YbSb+G1dCpr1phWuYpreFV0pV0
	 VOh4vOzeierg+n9FjQRaZCDf58M1zUjLa0jmlMgJ/d4/yXojyFZpQOR7QvfWuKrJiV6PM
	 Rxa7QFsEBmsciZx59Bm8hCG27qATX7ZOS0JjKRrTqJFUPdJOZbQkvmksUQ8LFmDNmJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791739394;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UQbDdSmfrnAzrB26R0EOICBv4unmwNfFMTDgTUubNbE=;
	b=Mfws0/VCecy0bzuA98MdWidU4k4Z05JKg4B142NZvdgYnhc6lMpAfQ29IjcBMhfBTqle
	 SKCWjx4upScJa8G2Uk1o+u28UIvk2YO+aiDwvHOl3IKMkG5+l0i3R+fHFv23P8R/8vTe4
	 /NA2k8Nz6bEvu9a8DgaMs1Xt3Ap0WL68J25aZoXcE9ukzOcNg00knHdxWnZlz93zUsM5U
	 hq0ZCKZa9cLFkYjK8OYf/4WVl7J7oQI7/7SK5a/VvYoPIx1nEHAXik+yQXIg340Z6ov0d
	 YtzlUxINdJbUB5CZ4/SOjjynJX1TuFvGLO0DXOuPWPYiwTA8iuQsjpiahLh98C50lmA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=Rp9ECl9L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791739394;
	bh=UQbDdSmfrnAzrB26R0EOICBv4unmwNfFMTDgTUubNbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t5IWq1MABkbZEnUkNwzV8FJ3MRBgaKERMT+90Ek+8WYR0rjLPKq7VZ+DAuySDgGdW
	 AX5J9XOFjLAZNA2lUTdEvxGdVV579cYgSmD2Qm16g09TQ8To3VXoL62hKXVLEO1ImF
	 XIUzoql9uwfh5/sNRFEJIJ3Q2UdYREcSI54qepVDdyFA7oscHIp2TWxA0b3lAfmqeM
	 5U3nMO43gB3LaU3GezTJhFMTYtFwHscgXZ4/OFx/98z2cpr+FAycpqozpImtoGCsYN
	 8falVQgQKI8TFKPb1yiY81hWNLfVJqwoVmRkguBj3p9eLSTWcifhHyB21vn6HOUYxC
	 9QTvBdZLdKSow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38E626067C;
	Sun, 11 Oct 2026 17:23:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8495D75
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6AAF5605CF
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xIpBFb0LBJEq for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 15:23:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6C634605E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791732195;
 b=m/ymQ3NbhqTH+l67RXoOUKWMvU41Ah+ik5ojb4/X7ANwVFV+9eIvex4o0e0Re2A0adAF
 6jjTXcUfe4/YGgZJFDc+CElCBgg8+cIGf1E4XY7pd738UdZwlBPd1PuC/ymOiv5z4qGfN
 b9Z5CkDWXFwX+BZS13f60gsflbYgXG+Vl6ABToj4gC0wrPC+oscPviDEV59Qf5CwoF9XT
 qVLZDjEkYDxw5kwz363/5H4qpAXMJms17h1mOEB/mU94oyv8zw1DonnJ98YOfCUNSFnwd
 ycUe7TlDn3uY8BCfymqxMJYkhT0uFHCqr+NdscjRE/IaTpKDNVLokfuDw2RKnvtZ55Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791732195;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=UQbDdSmfrnAzrB26R0EOICBv4unmwNfFMTDgTUubNbE=;
 b=kLRTZxkWlSgm4xE83R2fGC4is5RvwjKqhQCwuTOb9X8zgzER9zSdKLKJTS7Kiywo6pZ3
 8M1MSSsl2UHK/6EybFlfUbq+GLD4qAUCZvRVjEpMB7JE2cpHkXGY+Hpi/aqdIkne6/a4l
 g9UWVrAR2J06xfL2tIVLsOKHzvP+WceKitW4oDCMdTNPIIsd6i5mOckV5osaQj9l7QAq3
 24ZMnoDP3NxeHtguL2mhjS4CfJpyVANSTkGoNLbkYKD9Da3NsFiDvpU0HbtJiqAURUWsh
 DqVHcPhuDlEaeezNbq5jiklwLreVsmsdkMCvRSmE88rNYSRdK3Ay+LJc9rAo+SIhsIA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=Rp9ECl9L; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Rp9ECl9L
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C634605E4
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:14 +0000 (UTC)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0BF273F11C
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 15:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791732193;
 bh=UQbDdSmfrnAzrB26R0EOICBv4unmwNfFMTDgTUubNbE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Rp9ECl9L9ZdRu6QKmeEm0YibWa4/4Z6QtgPuTSw7pJV6oVt96BbVDgFfcAKa92Sfj
 7TgyKFuyGLPzjrbbXmJ9ZoF4mhFnwn6+N1iNeapho6kUMS2axkm1qQapT90512VIdY
 AWRkNc7PV20tCEJ3oIhUetxPS5ILQTqH/49pxT0QeG38nBLfOep9j4Sb90wU+V95zb
 gLmJIYaQlRHql/3TZaZ1z8n8QWoo/y8WlWu6JxRLfPZYe4s1mMOrb636rYR3u09aEb
 UTei1psJqOi676Bph9bZ2mv5EgKMR6M8FuA4V5IMDIIQbDMPZfSFn6qRul/P810Y/X
 oP9q/dF+MkMcjOe7GOzODXWFmNX1juEmAlJwRmBVQp02W+lxsSNvms8VZWmxVyW46D
 OCXrd2gUbMqLCdm7Z2cYhAs2Fi3GEGSyUWn0juclZlcKgz4xO0r9kAOEoJhpLML4zm
 8uIbo2Sa4RfkakmtPVaFsmx9Y2N9EmA1hRju+gr0a6019heNTnfu1anxGAu5kaNcuE
 AQLo1BCNEFmE1W/xxDhRj8vGkkHfm9DZr7W0nQJfmRskPvV/OOuLNWWmR/Zg2E/Oe8
 uPMurDZTCuAO+AQNkJlLBNtVlAqwB7vmAxYy6IZFqSCp/uPRlmtW1k+3jq1QeBwVzE
 Xe5/BApRMcYWoPXpaxxyIYVE=
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d001671a54so17267705ad.2
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 08:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791732191; x=1792336991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UQbDdSmfrnAzrB26R0EOICBv4unmwNfFMTDgTUubNbE=;
 b=0Xz9bINw7fwLJ1xsnZHsPTskbZt9xHDrsrXdhhmxbuNerouL9AZ7ENFFA8mOuHTkxm
 j6LrHrIOI8JchkBQDXj2j4I6wAfhjMw+CtmBPLM9A36fsQoNyvu2aK9w3Lptdksc2X3x
 gNcSeVLBhvyuHffmovbFV9E8H+GWSIq3PbyMTgtqwskL39izOPe1f3zJp4ry073u5vgl
 mn7jX5CjNddukSyC8sv5HTv8FsppNU4S2tFrTIQuSZildVIeiBVog0iIBVL4UXsjpGW3
 fSY0PWrX9S+w9nbmGJrbASCi4wLBKwIxiO827p280A6NkanZK0nTXQQkCJ/VbGB6Ilcb
 6d6w==
X-Gm-Message-State: AFq9FYJfWMBehliK0XtGgqhGut+RAcK8ivhfaB8Beoah93ae5KR7TOrc
 C+TykBoU5nHIEPkK1+UZlLlh9QY/LrcKI0BcuGGc5ZF5K4l1ZM4PvmRtL0PU0ArwnO54NwsxES1
 ScyBckS3PxjC0m4j2jnMk/uUZMIwfUM9Wf+09GeQV2F5AW1cdZYxvkFAFDhYuTqx55fLLhF8SMz
 jE+k50Jpbsn1FFJaG0Yw==
X-Gm-Gg: AYBFou12uNN3UM8tLRfW2Uv+LjZDIc5XhN0xPuvtBK+o1m84C6D37rVK2QX+NLw7K3i
 l8rtcINjU+2GC+7utnTPaHcPqWYCDab1GH3BtlaFwWb2FY9l7Y1VI7fS76PNNyP6oWFBtx6PSAq
 YqXKFJFGaQ3XvD3OiIGa9MgQI1LSbTVGH7GsOW53/AT3T0qMg9+i/IG4ZKsUTPpdfU59zfyLCEc
 Q3IVOjdvjJiqGV8dWAZOZ+b1R7R/PBlVp9nDVQpo+X3YRLKLeOlAuE/IKyi8lLCzQXFXM6ZHpTv
 qM4q7p3AO5o3MpeC+q5PKbODTPQVgMUHrhTbJqBG6Xp0R9aIB1xQHb+05WPlem2JKwoMQL2kxbP
 vbCKMVfLnWhr2BrLfW2MYguG0p9QMmmfMn1GuW3slRNmXAZPGyKKAR5i0l3r5a6UsyudcuQ==
X-Received: by 2002:a17:902:d60f:b0:2e4:a360:fcc6 with SMTP id
 d9443c01a7336-2e842bc1677mr62168435ad.35.1791732191417; 
 Sun, 11 Oct 2026 08:23:11 -0700 (PDT)
X-Received: by 2002:a17:902:d60f:b0:2e4:a360:fcc6 with SMTP id
 d9443c01a7336-2e842bc1677mr62168315ad.35.1791732191012; 
 Sun, 11 Oct 2026 08:23:11 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422b5fd2sm33300445ad.50.2026.10.11.08.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 08:23:10 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, anton@binarly.io,
 pranavkasthuri@gmail.com, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 5/5] test: py: cover invalid external data properties in
 fit_import_data()
Date: Sun, 11 Oct 2026 15:21:17 +0000
Message-ID: <20261011152235.8842-6-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011152235.8842-1-aristo.chen@canonical.com>
References: <20261011152235.8842-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 11 Oct 2026 17:23:03 +0000
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

Build an external-data FIT, then point one image's data-offset far past
the end of the file and, separately, make its data-size run a few bytes
past the end, re-processing the result with mkimage -F each time. Both
must be rejected with a diagnostic naming that image. Previously the
first crashed mkimage and the second silently imported the bytes beyond
the end of the file as image data.

Also check that a FIT whose images are all empty, which mkimage -E -p
writes with data-position past the end of the file, still re-processes,
since an empty region has nothing to read.

Finally, now that the import reads the properties through the FIT
accessors, check that an empty data-offset or data-size is skipped like
a missing property, so that the hashing stage reports the image instead
of the import reading it from the bytes that follow it.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fit_import_data.py | 91 ++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

diff --git a/test/py/tests/test_fit_import_data.py b/test/py/tests/test_fit_import_data.py
index 95f7114243e..c6f03db17ad 100644
--- a/test/py/tests/test_fit_import_data.py
+++ b/test/py/tests/test_fit_import_data.py
@@ -3,7 +3,7 @@
 #
 # Test mkimage import of external data in fit_import_data()
 
-"""Regression test for stale per-image state in fit_import_data().
+"""Regression tests for fit_import_data().
 
 The import loop used to keep the data pointer and external property name
 of the previous image, so an image node carrying data-size but neither
@@ -11,6 +11,11 @@ data-offset nor data-position imported the previous image's data and
 then made mkimage abort without printing any diagnostic. Such a node
 must be skipped by the import and reported by the later processing
 stages instead.
+
+The import also read each image's external data at the offset and size
+the FIT declares without checking them against the file, so a region
+reaching past the end of the file crashed mkimage or imported unrelated
+memory as image data. Such a region must be rejected before it is read.
 """
 
 import os
@@ -113,3 +118,87 @@ def test_fit_import_data_missing_offset(ubman):
                             capture_output=True, text=True)
     assert result.returncode != 0
     assert "Can't get image data/size" in result.stderr
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtput')
+def test_fit_import_data_out_of_range(ubman):
+    """External data outside the file must be rejected, not read"""
+    mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
+    params = {
+        'kernel1': fit_util.make_kernel(ubman, 'oob-kernel1.bin', 'first'),
+        'kernel2': fit_util.make_kernel(ubman, 'oob-kernel2.bin', 'second'),
+    }
+    its = fit_util.make_its(ubman, BASE_ITS, params, 'oob.its')
+    itb = fit_util.make_fname(ubman, 'oob.itb')
+
+    result = subprocess.run([mkimage, '-E', '-f', its, itb],
+                            capture_output=True, text=True)
+    assert result.returncode == 0, result.stderr
+
+    # Point kernel-2's data far past the end of the file
+    fdtput_keep_data(itb, '/images/kernel-2', 'data-offset', '0x40000000',
+                     opts=['-t', 'i'])
+    result = subprocess.run([mkimage, '-F', itb],
+                            capture_output=True, text=True)
+    assert result.returncode != 0
+    assert "image 'kernel-2': external data" in result.stderr
+    assert 'outside the FIT file' in result.stderr
+
+    # A size running just past the end of the file must be rejected too.
+    # kernel-2's data comes last, padded to 4 bytes, so 4 bytes more than
+    # its real size always reach past the end.
+    result = subprocess.run([mkimage, '-E', '-f', its, itb],
+                            capture_output=True, text=True)
+    assert result.returncode == 0, result.stderr
+    size = os.path.getsize(params['kernel2']) + 4
+    fdtput_keep_data(itb, '/images/kernel-2', 'data-size', f'{size:#x}',
+                     opts=['-t', 'i'])
+    result = subprocess.run([mkimage, '-F', itb],
+                            capture_output=True, text=True)
+    assert result.returncode != 0
+    assert "image 'kernel-2': external data" in result.stderr
+
+    # An empty region has nothing to read, so it is accepted even past the
+    # end of the file, which is where mkimage -E -p places it when every
+    # image is empty
+    for name in ('kernel1', 'kernel2'):
+        params[name] = fit_util.make_fname(ubman, f'oob-empty-{name}.bin')
+        with open(params[name], 'wb'):
+            pass
+    its = fit_util.make_its(ubman, BASE_ITS, params, 'oob-empty.its')
+    result = subprocess.run([mkimage, '-E', '-p', '0x1000', '-f', its, itb],
+                            capture_output=True, text=True)
+    assert result.returncode == 0, result.stderr
+    assert os.path.getsize(itb) < 0x1000
+    result = subprocess.run([mkimage, '-F', itb],
+                            capture_output=True, text=True)
+    assert result.returncode == 0, result.stderr
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtput')
+def test_fit_import_data_short_prop(ubman):
+    """An external data property shorter than one cell must not be read"""
+    mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
+    params = {
+        'kernel1': fit_util.make_kernel(ubman, 'short-kernel1.bin', 'first'),
+        'kernel2': fit_util.make_kernel(ubman, 'short-kernel2.bin', 'second'),
+    }
+    its = fit_util.make_its(ubman, BASE_ITS, params, 'short.its')
+    itb = fit_util.make_fname(ubman, 'short.itb')
+
+    # An empty property must be skipped like a missing one, so that the
+    # hashing stage reports the image, rather than read from the bytes
+    # that follow it, which would import a few bytes or the wrong data
+    for prop in ('data-offset', 'data-size'):
+        result = subprocess.run([mkimage, '-E', '-f', its, itb],
+                                capture_output=True, text=True)
+        assert result.returncode == 0, result.stderr
+        fdtput_keep_data(itb, '/images/kernel-2', prop)
+        result = subprocess.run([mkimage, '-F', itb],
+                                capture_output=True, text=True)
+        assert result.returncode != 0
+        assert "Can't get image data/size" in result.stderr
-- 
2.43.0

