Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54272D10F2E
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 12:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F04CC84201;
	Wed, 26 Nov 2025 13:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="DYyWhuPn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D55E83F3F; Wed, 26 Nov 2025 13:17:47 +0100 (CET)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAEAD841FF
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 13:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1764159464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TnBbH0jq510p88/tBYwLAV30JKs0tB8Mo9K7t1w2Nyk=;
 b=DYyWhuPnoFqFEjnvyXSG87FIV/Zscf/jmRSE9+v4YKHfVJsOgUOxJDswKmg2yJZ/KC140e
 OgSQhYY9J1EFLML8PIzT7tzkEg6kn3z1h7tFaj50dExc/yMIrNQ7n4bpSoqz5UUBIX7U3h
 EnQVFGw/I4MoAhSppm4do7MEth7dsYycL9vtfi/BzqkMPuIzCR/GQw6kTkYB7dIDEfMytT
 b22Ww9DwYkgl8+5IIQC0uj5qNZC4XUacTaNwXznDIoo950sS/VOYKtxOakMzkL/V6CPCWI
 y0G4nerzsoM+qymuAGNtGSUrSAQ+4gRFsPVMqWLI+GjmY4c6Cg9hxbW3o4ae4Q==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 26 Nov 2025 12:17:12 +0000
Subject: [PATCH v5 10/10] doc: board: amlogic: add u-boot-spl documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-spl-gx-v5-10-6cbffb2451ca@postmarketos.org>
References: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
In-Reply-To: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4593;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=Zdi10uel7EB7OHkvY+i9PQxsHbu5EHWXbT13N3Gijfc=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBpJu/ZFrLcsinR0c+zW4ooxcok7iqArXGyjCuCY
 Cmvc58nPSiJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaSbv2QAKCRCEr8vQ14ma
 Ax8ZD/4un0gPMcj7T+AvDLtvMNPiy2QHekKdY4ain+rFmVOw9709WGFCpRQItYFTuloQK9VJKgl
 jkP9SgW/mOTGrljvLJRRHTujroMUCdiypmAik0RMdAmLwT43ff/jEZPi7Sbg6FVASHAFxGumm7k
 ZKHVrut1nfzP6UwX5oJ6w334dF4p4Lv1E70VxoY16A1QewVgJSXfjzkjzf+z7YpuGIuAKKq5n79
 VH3SfxhhfaRRB3+Ach4AbPZpki0mNmLrUThWS4rgbw9ubWj0lZKJtRCK6INKdnvSZpPbgP2Gey5
 nDnHoAl87VVB5cDRcOBsatAOUUs4/Qt1zXxzvJhBqxbuapRCOJ75Vy+dgSdmYHp99TCOcvJXtF1
 jLz5z/LSAvAVwvuMpYtNpoSTJksq1z6u3FAmyfPJ0fQS3AqaZCvkbauHx6GRzqAqC/ziSQ5izJX
 Jjbtu+gp7ANPSofCSnBVkGG3/PBGW9X3pB9LUsr5g+JK601wIiJc6jfoCxTCqlynxba4pBmR0Y9
 KVg4psa9+a1EPveJXV32TxqQ20uz+fuuNi/vj3fEgTODrPrRFB4cVffSbkg2BertgN/koxSfBDw
 d9JxE+m4fCSzJ8oLnbwgLXf/rg+ytXW376556KYOnbYyMrlF8ZNYODSQ9n37qOx+YpoPcNs9ibh
 UO0ACLsr1N2EXKQ==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

Add building and usage instructions for SPL.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 doc/board/amlogic/index.rst             |  1 +
 doc/board/amlogic/pre-generated-fip.rst |  9 ++++
 doc/board/amlogic/spl.rst               | 77 +++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
index dcd935224ac..23380ac33f2 100644
--- a/doc/board/amlogic/index.rst
+++ b/doc/board/amlogic/index.rst
@@ -78,6 +78,7 @@ Boot Documentation
 
    boot-flow
    pre-generated-fip
+   spl
 
 Board Documentation
 -------------------
diff --git a/doc/board/amlogic/pre-generated-fip.rst b/doc/board/amlogic/pre-generated-fip.rst
index 6a43d776d43..d820bd09115 100644
--- a/doc/board/amlogic/pre-generated-fip.rst
+++ b/doc/board/amlogic/pre-generated-fip.rst
@@ -98,6 +98,13 @@ The repo also provides the following files used with GXBB boards:
 The repo also supports the open-source 'gxlimg' signing tool that can be used to sign
 U-Boot binaries for GXL/GXM/G12A/G12B/SM1 boards: https://github.com/repk/gxlimg
 
+The following binaries can be replaced with open-source implementations:
+
+- bl2.bin (GXBB and GXL only)
+- bl31.img (GXBB, GXL, AXG and G12A only)
+
+Refer to `Experimental U-Boot SPL Support`_ if you wish to replace them.
+
 Licensing
 ---------
 
@@ -129,3 +136,5 @@ clarified. The current Amlogic distribution licence is below:
     // THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
     // (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
     // OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+
+.. _`Experimental U-Boot SPL Support`: spl.rst
diff --git a/doc/board/amlogic/spl.rst b/doc/board/amlogic/spl.rst
new file mode 100644
index 00000000000..0495cd1ee9f
--- /dev/null
+++ b/doc/board/amlogic/spl.rst
@@ -0,0 +1,77 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Experimental U-Boot SPL Support
+===============================
+
+There's some experimental support for some Amlogic SoCs, in U-Boot SPL.  It
+replaces the proprietary bl2.bin blob used for DRAM init.  Currently Meson GX
+SoCs (GXBB, GXL) are supported.
+
+A subset of Amlogic boards have SPL enabled.  These boards have been tested and
+are known to work to an extent.
+
+
+Building Arm Trusted Firmware (TF-A)
+------------------------------------
+
+This U-Boot SPL port requires the BL31 stage of mainline Arm Trusted
+Firmware-A firmware. It provides an open source implementation of secure
+software for Armv8-A. Build it with:
+
+.. code-block:: bash
+
+    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
+    $ cd trusted-firmware-a
+    $ make CROSS_COMPILE=aarch64-linux-gnu- PLAT=your_soc AML_STDPARAMS=1
+
+Replace ``your_soc`` with the SoC target you wish to build for. For GXBB it's
+``gxbb`` and for GXL it's ``gxl``.
+
+
+Building a bl30_new.bin binary
+------------------------------
+
+``bl30_new.bin`` has both ``bl30.bin`` and ``bl301.bin`` binary blobs
+bundled. The former is the proper system control processor firmware and the
+latter is a "plug-in" for board-specific DVFS/suspend-resume parameters. For
+more info you may wish to read this page: `Pre-Generated FIP File Repo`_.
+
+To build using the FIP file repo, simply issue the following commands:
+
+.. code-block:: bash
+
+    $ cd amlogic-boot-fip/your_board
+    $ make bl30_new.bin
+
+
+.. _`Pre-Generated FIP File Repo`: pre-generated-fip.rst
+
+
+U-Boot compilation
+------------------
+
+U-Boot SPL is not enabled by default, instead there are config fragments that
+can be used to enable it, with per-board configuration:
+
+- ``spl-libretech-cc-1gb.config``: 1 GB LePotato board
+- ``spl-libretech-cc-2gb.config``: 2 GB LePotato board
+- ``spl-odroid-c2.config``: ODROID-C2
+- ``spl-videostrong-kii-pro.config``: Videostrong KII Pro
+
+Pick one of them then:
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=aarch64-linux-gnu-
+    $ export BL31=path/to/tf-a/bl31.bin                 # Upstream TF-A BL31 binary
+    $ export SCP=path/to/bl30_new.bin                   # bl30_new.bin binary
+    $ make <yourboardname>_defconfig spl-<yourboardname>.config
+    $ make
+
+Write to SD:
+
+.. code-block:: bash
+
+    $ DEV=/dev/boot_device
+    $ dd if=u-boot-meson-with-spl.bin of=$DEV conv=fsync,notrunc bs=512 seek=1
+

-- 
2.51.2

