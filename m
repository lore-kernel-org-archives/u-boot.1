Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCA6EE57DB
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 21:50:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8F6488BDE;
	Wed, 11 Sep 2024 23:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="mA9lqP2k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E894088C31; Wed, 11 Sep 2024 23:50:03 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33E2B88BDB
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id ACC3A120015;
 Thu, 12 Sep 2024 00:49:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru ACC3A120015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1726091399;
 bh=dFg/iXCjq/9gPiPZXYyp4N/rEWGEXZ71Pft5WsfxMPY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=mA9lqP2kzsk6nicPZnZdbetRuLTQd6ZZCOOLcrANxxO78lrDuLPKpNNVd6xBVt912
 2stvVuqhp4THng4feVvIDqzlDD/rnTXY/isdVFT8OoEkkFXVVdKgS29O0Ys7no0igb
 TuirEFtxJCj4u+lIITL+I0cO5vewGUXW2sE7o0SP8K0D3HFn400RUvtwRaEREo9Lr8
 UnU57W/Tw8YWYk3R9UN1BzfealPp0l/Ad9yqUHysKNVaEUP0iitGDvs1ub52qRAzCb
 sVvgcLz2tbXWmdIrqEcYVVw4d/B5ZkytsjJEAbpQ7+ykW0HYCEf2HLhOZq8XUQVryF
 YOUZoJa+sH26g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 12 Sep 2024 00:49:59 +0300 (MSK)
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <igor.opaniuk@gmail.com>, <mkorpershoek@baylibre.com>, <sjg@chromium.org>, 
 <semen.protsenko@linaro.org>, <trini@konsulko.com>,
 <colin.mcallister@garmin.com>, <4.shket@gmail.com>,
 <avromanov@salutedevices.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, <rockosov@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v2 6/6] test/py: introduce test for ab_dump command
Date: Thu, 12 Sep 2024 00:49:14 +0300
Message-ID: <20240911214945.15873-7-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911214945.15873-1-ddrokosov@salutedevices.com>
References: <20240911214945.15873-1-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.28.192.196]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187695 [Sep 12 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 32 0.3.32
 766319f57b3d5e49f2c79a76e7d7087b621090df,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 smtp.sberdevices.ru:7.1.1,5.0.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/09/11 19:25:00 #26555689
X-KSMG-AntiVirus-Status: Clean, skipped
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

The ab_dump command allows you to display ABC data directly on the
U-Boot console. During an A/B test execution, this test verifies the
accuracy of each field within the ABC data.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 test/py/tests/test_android/test_ab.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/test/py/tests/test_android/test_ab.py b/test/py/tests/test_android/test_ab.py
index 0d7b7995a9fa..9bf1a0eb00a6 100644
--- a/test/py/tests/test_android/test_ab.py
+++ b/test/py/tests/test_android/test_ab.py
@@ -54,6 +54,27 @@ def ab_disk_image(u_boot_console):
         di = ABTestDiskImage(u_boot_console)
     return di
 
+def ab_dump(u_boot_console, slot_num, crc):
+    output = u_boot_console.run_command('bcb ab_dump host 0#misc')
+    header, slot0, slot1 = output.split('\r\r\n\r\r\n')
+    slots = [slot0, slot1]
+    slot_suffixes = ['_a', '_b']
+
+    header = dict(map(lambda x: map(str.strip, x.split(':')), header.split('\r\r\n')))
+    assert header['Bootloader Control'] == '[misc]'
+    assert header['Active Slot'] == slot_suffixes[slot_num]
+    assert header['Magic Number'] == '0x42414342'
+    assert header['Version'] == '1'
+    assert header['Number of Slots'] == '2'
+    assert header['Recovery Tries Remaining'] == '0'
+    assert header['CRC'] == '{} (Valid)'.format(crc)
+
+    slot = dict(map(lambda x: map(str.strip, x.split(':')), slots[slot_num].split('\r\r\n\t- ')[1:]))
+    assert slot['Priority'] == '15'
+    assert slot['Tries Remaining'] == '6'
+    assert slot['Successful Boot'] == '0'
+    assert slot['Verity Corrupted'] == '0'
+
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('android_ab')
 @pytest.mark.buildconfigspec('cmd_bcb')
@@ -68,8 +89,10 @@ def test_ab(ab_disk_image, u_boot_console):
     assert 'Attempting slot a, tries remaining 7' in output
     output = u_boot_console.run_command('printenv slot_name')
     assert 'slot_name=a' in output
+    ab_dump(u_boot_console, 0, '0xd438d1b9')
 
     output = u_boot_console.run_command('bcb ab_select slot_name host 0:1')
     assert 'Attempting slot b, tries remaining 7' in output
     output = u_boot_console.run_command('printenv slot_name')
     assert 'slot_name=b' in output
+    ab_dump(u_boot_console, 1, '0x011ec016')
-- 
2.43.0

