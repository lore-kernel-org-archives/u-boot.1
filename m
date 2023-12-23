Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E99C4706F
	for <u-boot@archiver.kernel.org>; Sat, 23 Dec 2023 00:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEB2A877C8;
	Sat, 23 Dec 2023 01:44:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mCCrSrKo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C4A187579; Sat, 23 Dec 2023 01:44:53 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0B908765A
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 01:44:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703292287; x=1703897087; i=xypron.glpk@gmx.de;
 bh=IaPG7a7Of7PGsljf85C33tr12ykGzUSrJgQLSDKeYuk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
 References;
 b=mCCrSrKoJZueI93euW78J4+L6soUTume6w9l7/vbxNzepcevmf+jYIHrzzrstU54
 XygCZyoe0d+1CqT2E76QYusvZGbOZFbXcWMB5TkosEwI8knMXJgdxe7il2zYqpJZx
 04lsORFPQX/mivPx93CohSMPG/ASRVR/TDcWEKfmQchojIz/q67BFRBusqivZKxVz
 iQ5o3Mm6FgAnrBAgjpgjJ/U813El8qZOUB/An0qGVPWpq7Y47CfWfKc8Jep2zWARl
 rTzKsN3DFzdRq4ImMGZGcGA0h9ckysu0Jo38PLAUDlxaPV8vO8s61HDbhihFMYXvY
 +Enc6qQ/7CMPvfYatA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from x13s.fritz.box ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpOd-1qof702vFZ-00gLA3; Sat, 23
 Dec 2023 01:44:47 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 5/5] test: unit test for smbios command
Date: Sat, 23 Dec 2023 01:44:29 +0100
Message-ID: <20231223004429.247301-6-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223004429.247301-1-xypron.glpk@gmx.de>
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PjDELppHGRwGKfuJ3rtIamgzG+wizpHXZOnvfz1A77QYnFKb5qM
 8nSe9O7/iPLefJn7N1WSb9511FPI8s+WqRhlXxH5Ptse744dIA29VzP0g1v9beqKJ5/hRp5
 BPtR7gCnX1aCOIiqVex0hY21xiRNVBCk1GRqCcdcyRE+QNC7jhwFqKkDSj3QneTY0mg+vSd
 2WgIPPwsn8JnHSxUtTPNw==
UI-OutboundReport: notjunk:1;M01:P0:zZw5PJxPMNo=;8jWRr8OUfG7FJV26xcsvGOFoWhv
 5c8L9UbukcDdmnJxkE/MFRaJSr1b2pG8UHFYxX+PJNw/00a7OdJNsVYyx+rtqPW/ApDQUNMYv
 LDV8c0zqYtJddFmD/zcOGTnC1LzcwiRblhEDd0r4XjYSHf+8NlSu3rntYSR3zB76b4oelcoLU
 /lDrGJQHOqAE+3+PQpHfVO7ArpOXqGbZQMvqrcsZ04sZM+1+96vkdVsVDaOcM1gZwRCgFpqG+
 CMR+Bo0h0+3fGUFbGGrv1o4w+lqZiYbO14ccdtBhhF33jhWKXMiF3v2Pg7s2XWXyVXPMs/DY2
 3nRJE5mcvSc6ZdFWZil3hA3EYBgE2fX9EZ3ATDzI4rVuQuTREd7c/1de2govz24k1ycJ/37Qo
 hrtMeGrpBtrgAyawx1QlIeHYgAvaR+n1CF4QcApL4gNUqoXj4B+afxr4JXwHuRf3A/4nl8UDV
 OBQ5X/YsHPfELCTTczKqL5hXWKXsmp0F+R9Fybj5vEHmM+lcJ4mOXo5IRX1ijOq4gbX0EOMSA
 grPpbBzyTF7JSf+9T8FPzsNJCcbbq7M6KB+dcZIKqLu4Xap9LR9HVnVb/thTueIBuuxuE1DV6
 k2gWN6i1sc6znfZ1ZFJBJwiqn8iKdDAjQ3GGiyzytvrXid+RwKN9gSn7ia8c6zoMQYGQLqe8G
 MTvOoBQ/8dTB2GE1Mb2kHhwUrpnqEMsyeqsa1nNnIv5CSshPJZVXIChRsoJTgyqHYKz4Kz/IE
 69XZ32MaJgMMiP+7H1GWqAqYenCTWUZp73ReReTOgJ/tksafQmn19ig2OkAdLIf9fI8enm1ax
 4Ogu8+5Fo2wkzySM9Q6zvSagoU/D63fqZhIe/od4ImNWty4z5bnV9/GW/j+JUzUlLSGXg8Mdl
 +Vs8V7Rgs5WAI4qtYQfNgp3QVrVhpwmyR++l0VS8XVM4HK0yVcnSNwIwZ1LnORFVNl9ZB9+4K
 ILqz4CP5Dk4+05s529EDZfO5Nc8=
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

Provide a unit test for the smbios command.

Provide different test functions for QEMU, sandbox, and other systems.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 test/py/tests/test_smbios.py | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 test/py/tests/test_smbios.py

diff --git a/test/py/tests/test_smbios.py b/test/py/tests/test_smbios.py
new file mode 100644
index 0000000000..86d8d07539
=2D-- /dev/null
+++ b/test/py/tests/test_smbios.py
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+"""Test smbios command"""
+
+import pytest
+
+@pytest.mark.buildconfigspec('cmd_smbios')
+@pytest.mark.notbuildconfigspec('qfw_smbios')
+@pytest.mark.notbuildconfigspec('sandbox')
+def test_cmd_smbios(u_boot_console):
+    """Run the smbios command"""
+    output =3D u_boot_console.run_command('smbios')
+    assert 'DMI type 0,' in output
+    assert 'String 1: U-Boot' in output
+    assert 'DMI type 1,' in output
+    assert 'DMI type 2,' in output
+    assert 'DMI type 3,' in output
+    assert 'DMI type 4,' in output
+    assert 'DMI type 127,' in output
+
+@pytest.mark.buildconfigspec('cmd_smbios')
+@pytest.mark.buildconfigspec('qfw_smbios')
+@pytest.mark.notbuildconfigspec('sandbox')
+# TODO:
+# QEMU v8.2.0 lacks SMBIOS support for RISC-V
+# Once support is available in our Docker image we can remove the constra=
int.
+@pytest.mark.notbuildconfigspec('riscv')
+def test_cmd_smbios_qemu(u_boot_console):
+    """Run the smbios command on QEMU"""
+    output =3D u_boot_console.run_command('smbios')
+    assert 'DMI type 1,' in output
+    assert 'Manufacturer: QEMU' in output
+    assert 'DMI type 127,' in output
+
+@pytest.mark.buildconfigspec('cmd_smbios')
+@pytest.mark.buildconfigspec('sandbox')
+def test_cmd_smbios_sandbox(u_boot_console):
+    """Run the smbios command on the sandbox"""
+    output =3D u_boot_console.run_command('smbios')
+    assert 'DMI type 0,' in output
+    assert 'String 1: U-Boot' in output
+    assert 'DMI type 1,' in output
+    assert 'Manufacturer: sandbox' in output
+    assert 'DMI type 2,' in output
+    assert 'DMI type 3,' in output
+    assert 'DMI type 4,' in output
+    assert 'DMI type 127,' in output
=2D-
2.43.0

