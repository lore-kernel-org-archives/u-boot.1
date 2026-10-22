Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A1606A338
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gv8SQNtj;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=axI9m6s2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C4A140920;
	Thu, 22 Oct 2026 13:30:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eBVrmsqeP4EP; Thu, 22 Oct 2026 13:30:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0A0E740769
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792675851;
	b=C/9iDwf8VrzHZ4zFTEt45/Km7nkTjdVFeRyxqpmrus+62waDLwydHXV/RN7DGH8EpqH3
	 K0UkJWvsDOYrk9CUH0LYXZSNW6yCGN/hrYZ2+/qqP4hQ86zMkGONYpcv+2JyMjqveLEW/
	 dFhveOOj/KKogMIMAH4QGw59YkhL1z+Li1SreiKMO9gJmafxbT2gea16+kn9XwnJKcMTt
	 IFijsUX/w9aCMBJICy7r/dR+lHo6hdwOs4z7lhwxm/zx7mxjVAe0ufHDgIBSOAeYwu1q4
	 EcJq4cLdIDJyghlzYPBL+WKF4vFFSqLYd/2KtbW2jp9uIly3JneMjylO36SREfe3NCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792675851;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0bFJYIVJHpTtpREmGBLnnYkdnPgoarIxPHUSciXNXC4=;
	b=BdYPtzVDfqxM3EUG0rEnJKgRBM5BGT/+oEs2NbENbek0V1Xt9KE2aWJEu9QvItAfuHdX
	 EF97NHojqMRPNTLWFe74ulY0YwLQnZ9EIH++bitMQfl1SILNGU5Xz0ClBx9oQ2+oDkmSi
	 vGFUaJyZlWXC01z/iLsl7yZog2yb63QCxt+42XEc8rhQsveTQbQQoA+kq8bhY0jOQ58PY
	 vkgml2+Qu5cIaz23CYVZWheJBOvi5ou0W96BE75Q7AxA9axnIooCUD3QnTenTDsHzdrpB
	 oQs2TBsRPN//lK2PMvVtsswvwnkTGuUVTXuDO87auQ7XklJlXJoqjeNd33lPmTnBrbA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792675851;
	bh=0bFJYIVJHpTtpREmGBLnnYkdnPgoarIxPHUSciXNXC4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gv8SQNtjrl4+PvabJ0O+wGe2v5OiyCUgSmwhmyUleaWSySpwvMifEVlKWS5iR4eMy
	 x+SGdSW3ZvV4yqhz+MYN2Qc/hcihPU+DTLKQf6mdNTJVuZfLtolibrIqAhBgj0tyu6
	 ITfSW/EPExSIPVUQvM7RdUaG8/bDNjd/ZPlGnITiWBrb0nohygwQJKBfEJ/TqpZV0R
	 gDmXYUiwKVWABK5ILcxss6EEbx5cj3ewb4Q2y/WDDHkjaB3OoPgy0GRbPFivOyuz5Q
	 dTNwQPwMx0CIx0/LSA1TDnQm+cxP+D2+EC4i6vswxK84Lwz8R2xnE0WQaR5VUuAiTu
	 01bI/RbAcyK0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A0E740769;
	Thu, 22 Oct 2026 13:30:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 338D23AF
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 313DF8121A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h6-clykr0Y3s for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 13:30:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CECF781176
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792675848;
 b=N6M/TtHNu7HIqt6Ghi88BseMifXSWq33U/jxsy3npdx9wNl/T+JZ+O3sNTnpr67piS8w
 ZZOZY4nqdpSvx1+q/0YXsOCBHuvB9R2C8QbH2Ywj2xsVxQ3LKJM2OrmBV4EVX9ci0AZXE
 hv3ZM5o6KtiHi4s8tG2nlOeKqrH/UU4TtLbBO2UuhoZ5LDtVriCNKp2jMXMIpomyCNhZL
 titLyYLo07dudBrpnG/fKh+yYzLB5E+lIlWssNGZoudcNzP1FHK8OWjlsN+1o6BrLK45a
 t66pnopvoiGLqaMxc4g09yzDQHpchoQWc7OQTr5lA25DhWM0Om++qzSpuV6ekdsPbZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792675848;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=0bFJYIVJHpTtpREmGBLnnYkdnPgoarIxPHUSciXNXC4=;
 b=ZWMKZLfKxK1IDJkSWb/mYM9RmOGF4fUnqFP7N7He3AOXGGY0jRssj4rjiSRC6/3L3OLn
 Yq2zl3mvFRDFbm/fjautdgX3LZHzHdsWCSW9GcgzZhGw5eUIUUpP1qSTe5BL6azcibfy1
 1h1S7qv4xqvjdqRIUygFFsO3kKEjhRAnBYWV4lsYhXD+kt0voNyX3wtdV0hrNZq3D1bgg
 /2wlRBSH6mjtUCke6Oj/ofdySmHaexfvQwfOZTHLu0ghEl4WH2783BWszObn1yUMsY/wr
 GrUnaKlJ77Fchxq6psztSruh0TqIjIVlXJVzWSdDLKyuM7Lb+/pE1KicpRLIP2MIaAw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=axI9m6s2; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=axI9m6s2
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CECF781176
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E87EC60261;
 Thu, 22 Oct 2026 13:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA5D1F000C1;
 Thu, 22 Oct 2026 13:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792675844;
 bh=0bFJYIVJHpTtpREmGBLnnYkdnPgoarIxPHUSciXNXC4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=axI9m6s2WbuTTyX7F5ZeXDRXtVlTC58/JKNi7djhsDXhzXjceUZvRUaXX4w50si+w
 eMQw3df0SweM/HWYtdPzlFkAeo4iUVYVa+CY1lYVB/DD71jNvuvCyVSpWNRC0xyZWQ
 KB/moftTLhMWMhJHxt/KTMlNlrN2c6oOTkxanPmQCtOT7aCRHu8iVoL3F2TswFh4SL
 g4GRo8pQqt7Juju5oXQZjOpHl2nP7qwJf3npCkzUs+5jfZ5KrRA4uT7LEvopkzrd8S
 yaf08BUKMU0sfhRoNJHCQfzQf83qjkqUJW1W3RsHvgRSDPxMb50aqIeWuCQYFDxFDK
 WO7fWO2ZsAy7A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 22 Oct 2026 15:30:31 +0200
Subject: [PATCH v3 02/10] test/py: android: Move android image creation to
 a dedicated file
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-test-avb-fixes-v3-2-d3a6ff9ba097@kernel.org>
References: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
In-Reply-To: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10935;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=J1bxxRBT89tPW59Vg5Kgr2utvZMl9P61uX/FYYvgXAQ=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq2g/8de3s+u8AK24APon0XZTmvizZMaBoIsUJL
 WNv3wbbwE+JATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatoP/AAKCRAZDR20Zk4Z
 NVFLB/sFV25/ZjoPIMGW9Sjy8dgepBDlQt/Q12Undm0h8qAxl9ZZ6yWkwVlEbgrWvYNUAadRckK
 /T3uOta1Wf5/tQYpWzUHr0gSMuBleZVaREGy0Upwq5crFedGsrXU6I+u6lfDaNKlz4MjHykuD4d
 REMomaCsMhaf91GFqoXE6DiLM9C7IlNsC3mLwuym0QuxGu9wk20rTouBO8QrTwycYBtUY1T7gmB
 x4EXPQsCoo/1PEn6dl/cv69gQ3xIeicfZ088rmAEwHaLORoYp/TvqzRjY9ka7ww1a11iQ6orqvA
 rS+lHXlRYySEyyzOJGESZDHo7BZwkTupdijv/lQqSnlowOtC
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The image creation code in test_ut is huge and difficult to follow.
The android part contain code duplications when making mmc7.img/mmc8.img.

To prepare some code refactoring, move the Android specific bits into a
dedicated file under test_android/.

No functional change.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/py/tests/test_android/android_image.py | 135 ++++++++++++++++++++++++++++
 test/py/tests/test_ut.py                    | 129 +-------------------------
 2 files changed, 136 insertions(+), 128 deletions(-)

diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/test_android/android_image.py
new file mode 100644
index 000000000000..3bea311586bf
--- /dev/null
+++ b/test/py/tests/test_android/android_image.py
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: GPL-2.0
+"""Helpers to create Android disk images for sandbox testing."""
+
+import collections
+import os
+
+import utils
+from test_android import test_abootimg
+
+def setup_android_image(ubman):
+    """Create a 20MB disk image with Android partitions"""
+    Partition = collections.namedtuple('part', 'start,size,name')
+    parts = {}
+    disk_data = None
+
+    def set_part_data(partnum, data):
+        """Set the contents of a disk partition
+
+        This updates disk_data by putting data in the right place
+
+        Args:
+            partnum (int): Partition number to set
+            data (bytes): Data for that partition
+        """
+        nonlocal disk_data
+
+        start = parts[partnum].start * sect_size
+        disk_data = disk_data[:start] + data + disk_data[start + len(data):]
+
+    mmc_dev = 7
+    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
+    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
+    utils.run_and_log(ubman, f'cgpt create {fname}')
+
+    ptr = 40
+
+    # Number of sectors in 1MB
+    sect_size = 512
+    sect_1mb = (1 << 20) // sect_size
+
+    required_parts = [
+        {'num': 1, 'label':'misc', 'size': '1M'},
+        {'num': 2, 'label':'boot_a', 'size': '4M'},
+        {'num': 3, 'label':'boot_b', 'size': '4M'},
+        {'num': 4, 'label':'vendor_boot_a', 'size': '4M'},
+        {'num': 5, 'label':'vendor_boot_b', 'size': '4M'},
+    ]
+
+    for part in required_parts:
+        size_str = part['size']
+        if 'M' in size_str:
+            size = int(size_str[:-1]) * sect_1mb
+        else:
+            size = int(size_str)
+        utils.run_and_log(
+            ubman,
+            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
+        ptr += size
+
+    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
+    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
+
+    # Create a dict (indexed by partition number) containing the above info
+    for line in out.splitlines():
+        start, size, num, name = line.split(maxsplit=3)
+        parts[int(num)] = Partition(int(start), int(size), name)
+
+    with open(fname, 'rb') as inf:
+        disk_data = inf.read()
+
+    test_abootimg.AbootimgTestDiskImage(ubman, 'bootv4.img', test_abootimg.boot_img_hex)
+    boot_img = os.path.join(ubman.config.result_dir, 'bootv4.img')
+    with open(boot_img, 'rb') as inf:
+        set_part_data(2, inf.read())
+
+    test_abootimg.AbootimgTestDiskImage(ubman, 'vendor_boot.img', test_abootimg.vboot_img_hex)
+    vendor_boot_img = os.path.join(ubman.config.result_dir, 'vendor_boot.img')
+    with open(vendor_boot_img, 'rb') as inf:
+        set_part_data(4, inf.read())
+
+    with open(fname, 'wb') as outf:
+        outf.write(disk_data)
+
+    print(f'wrote to {fname}')
+
+    mmc_dev = 8
+    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
+    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
+    utils.run_and_log(ubman, f'cgpt create {fname}')
+
+    ptr = 40
+
+    # Number of sectors in 1MB
+    sect_size = 512
+    sect_1mb = (1 << 20) // sect_size
+
+    required_parts = [
+        {'num': 1, 'label':'misc', 'size': '1M'},
+        {'num': 2, 'label':'boot_a', 'size': '4M'},
+        {'num': 3, 'label':'boot_b', 'size': '4M'},
+    ]
+
+    for part in required_parts:
+        size_str = part['size']
+        if 'M' in size_str:
+            size = int(size_str[:-1]) * sect_1mb
+        else:
+            size = int(size_str)
+        utils.run_and_log(
+            ubman,
+            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
+        ptr += size
+
+    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
+    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
+
+    # Create a dict (indexed by partition number) containing the above info
+    for line in out.splitlines():
+        start, size, num, name = line.split(maxsplit=3)
+        parts[int(num)] = Partition(int(start), int(size), name)
+
+    with open(fname, 'rb') as inf:
+        disk_data = inf.read()
+
+    test_abootimg.AbootimgTestDiskImage(ubman, 'boot.img', test_abootimg.img_hex)
+    boot_img = os.path.join(ubman.config.result_dir, 'boot.img')
+    with open(boot_img, 'rb') as inf:
+        set_part_data(2, inf.read())
+
+    with open(fname, 'wb') as outf:
+        outf.write(disk_data)
+
+    print(f'wrote to {fname}')
+
+    return fname
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 2a5acc18c612..c1b5bc056023 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -19,7 +19,7 @@ import utils
 # pylint: disable=E0611
 from tests import fs_helper
 from fs_helper import DiskHelper, FsHelper
-from test_android import test_abootimg
+from test_android.android_image import setup_android_image
 
 def mkdir_cond(dirname):
     """Create a directory if it doesn't already exist
@@ -506,133 +506,6 @@ def setup_cros_image(ubman):
 
     return fname
 
-def setup_android_image(ubman):
-    """Create a 20MB disk image with Android partitions"""
-    Partition = collections.namedtuple('part', 'start,size,name')
-    parts = {}
-    disk_data = None
-
-    def set_part_data(partnum, data):
-        """Set the contents of a disk partition
-
-        This updates disk_data by putting data in the right place
-
-        Args:
-            partnum (int): Partition number to set
-            data (bytes): Data for that partition
-        """
-        nonlocal disk_data
-
-        start = parts[partnum].start * sect_size
-        disk_data = disk_data[:start] + data + disk_data[start + len(data):]
-
-    mmc_dev = 7
-    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
-    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
-    utils.run_and_log(ubman, f'cgpt create {fname}')
-
-    ptr = 40
-
-    # Number of sectors in 1MB
-    sect_size = 512
-    sect_1mb = (1 << 20) // sect_size
-
-    required_parts = [
-        {'num': 1, 'label':'misc', 'size': '1M'},
-        {'num': 2, 'label':'boot_a', 'size': '4M'},
-        {'num': 3, 'label':'boot_b', 'size': '4M'},
-        {'num': 4, 'label':'vendor_boot_a', 'size': '4M'},
-        {'num': 5, 'label':'vendor_boot_b', 'size': '4M'},
-    ]
-
-    for part in required_parts:
-        size_str = part['size']
-        if 'M' in size_str:
-            size = int(size_str[:-1]) * sect_1mb
-        else:
-            size = int(size_str)
-        utils.run_and_log(
-            ubman,
-            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
-        ptr += size
-
-    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
-    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
-
-    # Create a dict (indexed by partition number) containing the above info
-    for line in out.splitlines():
-        start, size, num, name = line.split(maxsplit=3)
-        parts[int(num)] = Partition(int(start), int(size), name)
-
-    with open(fname, 'rb') as inf:
-        disk_data = inf.read()
-
-    test_abootimg.AbootimgTestDiskImage(ubman, 'bootv4.img', test_abootimg.boot_img_hex)
-    boot_img = os.path.join(ubman.config.result_dir, 'bootv4.img')
-    with open(boot_img, 'rb') as inf:
-        set_part_data(2, inf.read())
-
-    test_abootimg.AbootimgTestDiskImage(ubman, 'vendor_boot.img', test_abootimg.vboot_img_hex)
-    vendor_boot_img = os.path.join(ubman.config.result_dir, 'vendor_boot.img')
-    with open(vendor_boot_img, 'rb') as inf:
-        set_part_data(4, inf.read())
-
-    with open(fname, 'wb') as outf:
-        outf.write(disk_data)
-
-    print(f'wrote to {fname}')
-
-    mmc_dev = 8
-    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
-    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
-    utils.run_and_log(ubman, f'cgpt create {fname}')
-
-    ptr = 40
-
-    # Number of sectors in 1MB
-    sect_size = 512
-    sect_1mb = (1 << 20) // sect_size
-
-    required_parts = [
-        {'num': 1, 'label':'misc', 'size': '1M'},
-        {'num': 2, 'label':'boot_a', 'size': '4M'},
-        {'num': 3, 'label':'boot_b', 'size': '4M'},
-    ]
-
-    for part in required_parts:
-        size_str = part['size']
-        if 'M' in size_str:
-            size = int(size_str[:-1]) * sect_1mb
-        else:
-            size = int(size_str)
-        utils.run_and_log(
-            ubman,
-            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
-        ptr += size
-
-    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
-    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
-
-    # Create a dict (indexed by partition number) containing the above info
-    for line in out.splitlines():
-        start, size, num, name = line.split(maxsplit=3)
-        parts[int(num)] = Partition(int(start), int(size), name)
-
-    with open(fname, 'rb') as inf:
-        disk_data = inf.read()
-
-    test_abootimg.AbootimgTestDiskImage(ubman, 'boot.img', test_abootimg.img_hex)
-    boot_img = os.path.join(ubman.config.result_dir, 'boot.img')
-    with open(boot_img, 'rb') as inf:
-        set_part_data(2, inf.read())
-
-    with open(fname, 'wb') as outf:
-        outf.write(disk_data)
-
-    print(f'wrote to {fname}')
-
-    return fname
-
 def setup_cedit_file(ubman):
     """Set up a .dtb file for use with testing expo and configuration editor"""
     infname = os.path.join(ubman.config.source_dir,

-- 
2.56.0

