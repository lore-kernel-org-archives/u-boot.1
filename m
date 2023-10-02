Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742F8E784AC
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 13:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6495E87156;
	Mon,  2 Oct 2023 15:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=bitbiz.be
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FF0F87143; Mon,  2 Oct 2023 10:01:47 +0200 (CEST)
Received: from web01.gemnuservers.be (web01.gemnuservers.be [109.68.161.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E63487141
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 10:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=bitbiz.be
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lars@bitbiz.be
Received: from d5152ca9a.static.telenet.be ([81.82.202.154]
 helo=lars-ubuntu.telenet.be)
 by web01.gemnuservers.be with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96)
 (envelope-from <lars@bitbiz.be>) id 1qnDs9-0006tA-02;
 Mon, 02 Oct 2023 10:01:45 +0200
From: Lars Feyaerts <lars@bitbiz.be>
To: u-boot@lists.denx.de
Cc: Lars Feyaerts <lars@bitbiz.be>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Massimo Pegorer <massimo.pegorer@vimar.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/2] mkimage: allow internalization of data-position
Date: Mon,  2 Oct 2023 10:00:14 +0200
Message-Id: <20231002080014.1861669-2-lars@bitbiz.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002080014.1861669-1-lars@bitbiz.be>
References: <20231002080014.1861669-1-lars@bitbiz.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: lars@bitbiz.be
X-Mailman-Approved-At: Mon, 02 Oct 2023 15:00:05 +0200
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

Make it possible for data that was externalized using a static external
position (-p) to be internalized. Enables the ability to convert
existing FIT images built with -p to be converted to a FIT image where the
data is internal, to be converted to a FIT image where the data is
external relative to the end of the FIT (-E) or change the initial
static external position to a different static external position (-p).

Removing the original external-data-related properties ensures that
they're not present after conversion. Without this, they would still be
present in the resulting FIT even if the FIT has been, for example,
internalized.

Signed-off-by: Lars Feyaerts <lars@bitbiz.be>
---

 doc/mkimage.1     | 19 +++++++++++++++++++
 tools/fit_image.c | 26 +++++++++++++++++++++-----
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/doc/mkimage.1 b/doc/mkimage.1
index 76c7859bb03..d0a038a880a 100644
--- a/doc/mkimage.1
+++ b/doc/mkimage.1
@@ -860,6 +860,25 @@ verify signatures is added to u\-boot.dtb with required = "conf" property.
 	\-K u\-boot.dtb -r kernel.itb
 .EE
 .RE
+.P
+Convert an existing FIT image from any of the three types of data storage
+(internal, external data-offset or external data-position) to another type
+of data storage.
+.RS
+.P
+.EX
+\fB// convert FIT from internal data to data-position
+\fBmkimage -p 0x20000 -F internal_data.itb
+.EE
+.EX
+\fB// convert FIT from data-position to data-offset
+\fBmkimage -E -F external_data-position.itb
+.EE
+.EX
+\fB// convert FIT from data-offset to internal data
+\fBmkimage -F external_data-offset.itb
+.EE
+.RE
 .
 .SH SEE ALSO
 .BR dtc (1),
diff --git a/tools/fit_image.c b/tools/fit_image.c
index 9fe69ea0d9f..10f36e93422 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -616,6 +616,8 @@ err:
 static int fit_import_data(struct image_tool_params *params, const char *fname)
 {
 	void *fdt, *old_fdt;
+	void *data = NULL;
+	const char *ext_data_prop = NULL;
 	int fit_size, new_size, size, data_base;
 	int fd;
 	struct stat sbuf;
@@ -659,14 +661,28 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 		int buf_ptr;
 		int len;
 
-		buf_ptr = fdtdec_get_int(fdt, node, "data-offset", -1);
-		len = fdtdec_get_int(fdt, node, "data-size", -1);
-		if (buf_ptr == -1 || len == -1)
+		/*
+		 * FIT_DATA_OFFSET_PROP and FIT_DATA_POSITION_PROP are never both present,
+		 *  but if they are, prefer FIT_DATA_OFFSET_PROP as it was there first
+		 */
+		buf_ptr = fdtdec_get_int(fdt, node, FIT_DATA_POSITION_PROP, -1);
+		if (buf_ptr != -1) {
+			ext_data_prop = FIT_DATA_POSITION_PROP;
+			data = old_fdt + buf_ptr;
+		}
+		buf_ptr = fdtdec_get_int(fdt, node, FIT_DATA_OFFSET_PROP, -1);
+		if (buf_ptr != -1) {
+			ext_data_prop = FIT_DATA_OFFSET_PROP;
+			data = old_fdt + data_base + buf_ptr;
+		}
+		len = fdtdec_get_int(fdt, node, FIT_DATA_SIZE_PROP, -1);
+		if (!data || len == -1)
 			continue;
 		debug("Importing data size %x\n", len);
 
-		ret = fdt_setprop(fdt, node, "data",
-				  old_fdt + data_base + buf_ptr, len);
+		ret = fdt_setprop(fdt, node, FIT_DATA_PROP, data, len);
+		ret = fdt_delprop(fdt, node, ext_data_prop);
+
 		if (ret) {
 			debug("%s: Failed to write property: %s\n", __func__,
 			      fdt_strerror(ret));
-- 
2.34.1

