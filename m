Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A047D2AB20
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 11:45:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F3778908A;
	Tue, 29 Oct 2024 12:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fIncPXxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3858D89164; Tue, 29 Oct 2024 12:45:11 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6277188D3A
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 12:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730202297; x=1730807097; i=xypron.glpk@gmx.de;
 bh=xLqDizx8AeegBy9fTRtg1bcGwqdUl7jZ27g2JbOYvo0=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=fIncPXxAJ4gQFAfT44oNdwPW8ccWuXiBgauAoSKkXxaxMt5julYekp+wV77lLgX4
 XPIkXSALBNgcukPGzCjHYm/67to0IUA8EHc83ayju/Q+BsOLXeVW/Bsmbzjc5HuF0
 1395d/XOEh9CHz1/aHkoKk6tvCaYFLbT2G9umPy2RVOJ/r31NXH51Cgyxesw7P7py
 NRH6ImaTjcC5IczH5YVls7DX5BGOd/Cpgi9XP2E6EJzo4Ka2xZ1zAUA5I0xAFRJmF
 rf52tFT9dMY2BfukaAFdaRXPXEPeYM/th27t/11w+6fYIEUBKK1Kfr0jwvWUm48IT
 5tAUCP0Ty3CrSvGZqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([145.103.114.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6Udt-1tCdTE0UNF-00FzrW; Tue, 29
 Oct 2024 12:44:57 +0100
Date: Tue, 29 Oct 2024 12:44:54 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH 10/15] efi_loader: Add support for logging EFI calls
User-Agent: K-9 Mail for Android
In-Reply-To: <20241028124815.47262-11-sjg@chromium.org>
References: <20241028124815.47262-1-sjg@chromium.org>
 <20241028124815.47262-11-sjg@chromium.org>
Message-ID: <36E4997F-F709-4B1C-8D43-8D5862898FF6@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w0uQl/MvHgbDkgpi579DNzEJuzVBHdeSw17GiDPr4jHcJLAWIp6
 70kgFsu1Fu3OASMYwwR6cB53swl+K28UI5SF0eNTlCOw4Dyics2yWYsoMByN6i+eoz4WVPT
 47zCexeX3MzVBHJlmPxHP5T3qiUU08S6LYLlVjdWcdM/O8OloEHekhlKNC8alSj+T60nbdA
 x7YfA77R+2Omx5NvDPbKA==
UI-OutboundReport: notjunk:1;M01:P0:3zNDcQR305s=;1xey588DFLAtEBncZ6AL6QVe6qa
 I4mT03pK4v7KFlADsw8LG/zcj2haMAv2X8kNAJ/7Idx8eFMTmiuf0STFtSy2VNJfBqbD3HDnz
 I3dgqbewEh6vIeNXDVz27EcwudxrQZKx6mkpJeXQ66Ui71LOogp4lcrJ0TveqZcmk4fUmPyEN
 KMGX3+dIs7Mvt8R7hKOPWgxnMLSkQq/u8PI8Cn+/SKtUnzMe+r3+IJ8SfXGmctYRHPuehnk/X
 2E0jLpMwIqx8AEUe+rm+8e6X8efcDQThIvmbfNbUtWap90Ctl9rEYofwM1QpdCW5j8hnQBaLK
 nBvisCz3cgQFoWIAq/LEa6hJ1HogM0EwfXhNqj7eAd9t56mjJcV9xffO/UmqNogMVTXGETHvw
 N7B+8GVb6eYjaRiAB1wvynt4pXeyGrO8AgTrkMmvwuVk6GW/OE6nrJ67wjIruPEwAcWycJlhP
 DXOJVJPiWY3bbcDd52Ntya5bSGgaNVQysvg5TfsqyZ+ErLG77wnl5hKONJUo5FBA/m3FUD/R4
 bBrXnvxDZ4CzVVR2HY7x7Imr4VpCyJIDMHc67el5AhuDXPJ25TWmn06P144DSTX1OHidEK8mL
 Wx62MnWP0CbjDcL/XbBpUBtuLnZABL/o608MZepjIRT342xZAeU3xegNrJ2oGNISv+8IfjMAz
 HY1w6GwKxOaoAnWa2cBoYwSF/YlUyb3K0akqPruRz4xkJygVHGl/NtsB9W2TSBbg2PsdoLtLj
 yEvqakwzifRThkrEHtyvFq7Rj7VVSntF7mJVnC60qOyoFmfRywFkLCZLfBx29/sav6yZqYmq3
 HBDwbYCNG0/FfzZvIuGGy8lkJdy0ahPT3daL9lVhQJFi0=
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



Am 28=2E Oktober 2024 13:48:01 MEZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>The current logging system suffers from some disadvantages, mainly that
>it writes its output to the console and cannot be easily reviewed=2E
>
>Add a dedicated log, storing records in a binary format and including
>the result codes and any return values from each call=2E The log is built
>sequentially in memory and can be reviewed after any EFI operation=2E It
>could potentially be written to media for later review, but that is not
>implemented so far=2E

We already have log_debug=2E

We should use it in EFI_ENTRY, EFI_PRINT, EFI_EXIT=2E

The missing piece might be a log driver to save the log wherever you want =
it for tests=2E

Best regards

Heinrich

>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
> MAINTAINERS              |   6 +
> include/bloblist=2Eh       |   1 +
> include/efi=2Eh            |   1 +
> include/efi_log=2Eh        | 169 ++++++++++++++++++++++++++
> lib/efi_loader/Kconfig   |  19 +++
> lib/efi_loader/Makefile  |   1 +
> lib/efi_loader/efi_log=2Ec | 256 +++++++++++++++++++++++++++++++++++++++
> 7 files changed, 453 insertions(+)
> create mode 100644 include/efi_log=2Eh
> create mode 100644 lib/efi_loader/efi_log=2Ec
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 38c714cf46a=2E=2E9ade0ca4bc3 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -1067,6 +1067,12 @@ F:	lib/efi/efi_app=2Ec
> F:	scripts/build-efi=2Esh
> F:	test/dm/efi_media=2Ec
>=20
>+EFI LOGGING
>+M:	Simon Glass <sjg@chromium=2Eorg>
>+S:	Maintained
>+F:	include/efi_log=2Eh
>+F:	lib/efi_loader/efi_log=2Ec
>+
> EFI PAYLOAD
> M:	Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
> M:	Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>diff --git a/include/bloblist=2Eh b/include/bloblist=2Eh
>index ff32d3fecfd=2E=2E1e1ca34aa92 100644
>--- a/include/bloblist=2Eh
>+++ b/include/bloblist=2Eh
>@@ -153,6 +153,7 @@ enum bloblist_tag_t {
> 	BLOBLISTT_U_BOOT_SPL_HANDOFF	=3D 0xfff000, /* Hand-off info from SPL */
> 	BLOBLISTT_VBE			=3D 0xfff001, /* VBE per-phase state */
> 	BLOBLISTT_U_BOOT_VIDEO		=3D 0xfff002, /* Video info from SPL */
>+	BLOBLISTT_EFI_LOG		=3D 0xfff003, /* Log of EFI calls */
> };
>=20
> /**
>diff --git a/include/efi=2Eh b/include/efi=2Eh
>index 84640cf7b25=2E=2Ef7419b80d4d 100644
>--- a/include/efi=2Eh
>+++ b/include/efi=2Eh
>@@ -127,6 +127,7 @@ static inline void *guidcpy(void *dst, const void *sr=
c)
> #define EFI_COMPROMISED_DATA		(EFI_ERROR_MASK | 33)
> #define EFI_IP_ADDRESS_CONFLICT		(EFI_ERROR_MASK | 34)
> #define EFI_HTTP_ERROR			(EFI_ERROR_MASK | 35)
>+#define EFI_ERROR_COUNT			36
>=20
> #define EFI_WARN_UNKNOWN_GLYPH		1
> #define EFI_WARN_DELETE_FAILURE		2
>diff --git a/include/efi_log=2Eh b/include/efi_log=2Eh
>new file mode 100644
>index 00000000000=2E=2E1988e5f9df0
>--- /dev/null
>+++ b/include/efi_log=2Eh
>@@ -0,0 +1,169 @@
>+/* SPDX-License-Identifier: GPL-2=2E0+ */
>+/*
>+ * Logging (to memory) of calls from an EFI app
>+ *
>+ * Copyright 2024 Google LLC
>+ * Written by Simon Glass <sjg@chromium=2Eorg>
>+ */
>+
>+#ifndef __EFI_LOG_H
>+#define __EFI_LOG_H
>+
>+#include <linux/types=2Eh>
>+#include <efi=2Eh>
>+
>+/**
>+ * enum efil_tag - Types of logging records which can be created
>+ */
>+enum efil_tag {
>+	EFILT_TESTING,
>+
>+	EFILT_COUNT,
>+};
>+
>+/**
>+ * struct efil_rec_hdr - Header for each logging record
>+ *
>+ * @tag: Tag which indicates the type of the record
>+ * @size: Size of the record in bytes
>+ * @ended: true if record has been completed (i=2Ee=2E the function retu=
rned), false
>+ *	if it is still pending
>+ * @e_ret: Records the return function from the logged function
>+ */
>+struct efil_rec_hdr {
>+	enum efil_tag tag;
>+	int size;
>+	bool ended;
>+	efi_status_t e_ret;
>+};
>+
>+/**
>+ * struct efil_hdr - Holds the header for the log
>+ *
>+ * @upto: Offset at which to store the next log record
>+ * @size: Total size of the log in bytes
>+ */
>+struct efil_hdr {
>+	int upto;
>+	int size;
>+};
>+
>+enum efil_test_t {
>+	EFI_LOG_TEST0,
>+	EFI_LOG_TEST1,
>+
>+	EFI_LOG_TEST_COUNT,
>+};
>+
>+/**
>+ * struct efil_testing - used for testing the log
>+ */
>+struct efil_testing {
>+	enum efil_test_t enum_val;
>+	efi_uintn_t int_val;
>+	u64 *memory;
>+	void **buffer;
>+	u64 e_memory;
>+	void *e_buffer;
>+};
>+
>+/**
>+ * struct efil_allocate_pages - holds info from efi_allocate_pages() cal=
l
>+ *
>+ * @e_memory: Contains the value of *@memory on return from the EFI func=
tion
>+ */
>+struct efil_allocate_pages {
>+	enum efi_allocate_type type;
>+	enum efi_memory_type memory_type;
>+	efi_uintn_t pages;
>+	u64 *memory;
>+	u64 e_memory;
>+};
>+
>+/*
>+ * The functions below are in pairs, with a 'start' and 'end' call for e=
ach EFI
>+ * function=2E The 'start' function (efi_logs_=2E=2E=2E) is called when =
the function is
>+ * started=2E It records all the arguments=2E The 'end' function (efi_lo=
ge_=2E=2E=2E) is
>+ * called when the function is ready to return=2E It records any output =
arguments
>+ * as well as the return value=2E
>+ *
>+ * The start function returns the offset of the log record=2E This must =
be passed
>+ * to the end function, so it can add the status code and any other usef=
ul
>+ * information=2E It is not possible for the end functions to remember t=
he offset
>+ * from the associated start function, since EFI functions may be called=
 in a
>+ * nested way and there is no obvious way to determine the log record to=
 which
>+ * the end function refers=2E
>+ *
>+ * If the start function returns an error code (i=2Ee=2E an offset < 0) =
then it is
>+ * safe to pass that to the end function=2E It will simply ignore the op=
eration=2E
>+ * Common errors are -ENOENT if there is no log and -ENOSPC if the log i=
s full
>+ */
>+
>+#if CONFIG_IS_ENABLED(EFI_LOG)
>+
>+/**
>+ * efi_logs_testing() - Record a test call to an efi function
>+ *
>+ * @enum_val:	enum value
>+ * @int_val:	integer value
>+ * @buffer:	place to write pointer address
>+ * @memory:	place to write memory address
>+ * Return:	log-offset of this new record, or -ve error code
>+ */
>+int efi_logs_testing(enum efil_test_t enum_val, efi_uintn_t int_value,
>+		     void *buffer, u64 *memory);
>+
>+/**
>+ * efi_loge_testing() - Record a return from a test call
>+ *
>+ * This stores the value of the pointers also
>+ *
>+ * ofs: Offset of the record to end
>+ * efi_ret: status code to record
>+ */
>+int efi_loge_testing(int ofs, efi_status_t efi_ret);
>+
>+#else /* !EFI_LOG */
>+
>+static inline int efi_logs_testing(enum efil_test_t enum_val,
>+				   efi_uintn_t int_value, void *buffer,
>+				   u64 *memory)
>+{
>+	return -ENOSYS;
>+}
>+
>+static inline int efi_loge_testing(int ofs, efi_status_t efi_ret)
>+{
>+	return -ENOSYS;
>+}
>+
>+#endif /* EFI_LOG */
>+
>+/* below are some general functions */
>+
>+/**
>+ * efi_log_show() - Show the EFI log
>+ *
>+ * Displays the log of EFI boot-services calls which are so-far enabled =
for
>+ * logging
>+ *
>+ * Return: 0 on success, or -ve error code
>+ */
>+int efi_log_show(void);
>+
>+/**
>+ * efi_log_reset() - Reset the log, erasing all records
>+ *
>+ * Return 0 if OK, -ENOENT if the log could not be found
>+
>+ */
>+int efi_log_reset(void);
>+
>+/**
>+ * efi_log_init() - Create a log in the bloblist, then reset it
>+ *
>+ * Return 0 if OK, -ENOMEM if the bloblist is not large enough
>+ */
>+int efi_log_init(void);
>+
>+#endif /* __EFI_LOG_H */
>diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>index 69b2c9360d8=2E=2E37572c82f54 100644
>--- a/lib/efi_loader/Kconfig
>+++ b/lib/efi_loader/Kconfig
>@@ -531,6 +531,25 @@ config EFI_SCROLL_ON_CLEAR_SCREEN
> 	  to capture complete boot logs (except for interactive menus etc=2E)
> 	  and can ease debugging related issues=2E
>=20
>+config EFI_LOG
>+	bool "Enable logging of EFI operations"
>+	select BLOBLIST
>+	help
>+	  This enables maintaining a log of EFI boot-time services, useful for
>+	  debugging=2E It keeps track of some of the calls which are made, so f=
ar
>+	  just those related to memory allocation=2E
>+
>+config EFI_LOG_SIZE
>+	hex "Size of EFI log"
>+	depends on EFI_LOG
>+	default 0x4000
>+	help
>+	   Sets the size of the EFI log in bytes=2E The log is stored in the
>+	   bloblist so if its size is insufficient, U-Boot will raise an error=
=2E
>+
>+	   The amount of space needed depends on the EFI app being run=2E When
>+	   space runes out, further EFI calls will not be logged=2E
>+
> endmenu
>=20
> menu "EFI bootmanager"
>diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>index 00d18966f9e=2E=2E8ec240cb864 100644
>--- a/lib/efi_loader/Makefile
>+++ b/lib/efi_loader/Makefile
>@@ -38,6 +38,7 @@ obj-y +=3D efi_file=2Eo
> obj-$(CONFIG_EFI_LOADER_HII) +=3D efi_hii=2Eo
> obj-y +=3D efi_image_loader=2Eo
> obj-y +=3D efi_load_options=2Eo
>+obj-$(CONFIG_EFI_LOG) +=3D efi_log=2Eo
> obj-y +=3D efi_memory=2Eo
> obj-y +=3D efi_root_node=2Eo
> obj-y +=3D efi_runtime=2Eo
>diff --git a/lib/efi_loader/efi_log=2Ec b/lib/efi_loader/efi_log=2Ec
>new file mode 100644
>index 00000000000=2E=2E01e495d3995
>--- /dev/null
>+++ b/lib/efi_loader/efi_log=2Ec
>@@ -0,0 +1,256 @@
>+// SPDX-License-Identifier: GPL-2=2E0+
>+/*
>+ * Logging (to memory) of calls from an EFI app
>+ *
>+ * Copyright 2024 Google LLC
>+ * Written by Simon Glass <sjg@chromium=2Eorg>
>+ */
>+
>+#define LOG_CATEGORY LOGC_EFI
>+
>+#include <bloblist=2Eh>
>+#include <efi_log=2Eh>
>+#include <errno=2Eh>
>+#include <log=2Eh>
>+
>+/* names for enum efil_tag (abbreviated to keep output to a single line)=
 */
>+static const char *tag_name[EFILT_COUNT] =3D {
>+	"testing",
>+};
>+
>+/* names for error codes, trying to keep them short */
>+static const char *error_name[EFI_ERROR_COUNT] =3D {
>+	"OK",
>+	"load",
>+	"inval_param",
>+	"unsupported",
>+	"bad_buf_sz",
>+	"buf_small",
>+	"not_ready",
>+	"device",
>+	"write_prot",
>+	"out_of_rsrc",
>+	"vol_corrupt",
>+	"vol_full",
>+	"no_media",
>+	"media_chg",
>+	"not_found",
>+	"no access",
>+	"no_response",
>+	"no_mapping",
>+	"timeout",
>+	"not_started",
>+	"already",
>+	"aborted",
>+	"icmp",
>+	"tftp",
>+	"protocol",
>+	"bad version",
>+	"sec_violate",
>+	"crc_error",
>+	"end_media",
>+	"end_file",
>+	"inval_lang",
>+	"compromised",
>+	"ipaddr_busy",
>+	"http",
>+};
>+
>+static const char *test_enum_name[EFI_LOG_TEST_COUNT] =3D {
>+	"test0",
>+	"test1",
>+};
>+
>+/**
>+ * prep_rec() - prepare a new record in the log
>+ *
>+ * This creates a new record at the next available position, setting it =
up ready
>+ * to hold data=2E The size and tag are set up=2E
>+ *
>+ * The log is updated so that the next record will start after this one
>+ *
>+ * @tag: tag of the EFI call to record
>+ * @size: Number of bytes in the caller's struct
>+ * @recp: Set to point to where the caller should add its data
>+ * Return: Offset of this record (must be passed to finish_rec())
>+ */
>+static int prep_rec(enum efil_tag tag, uint str_size, void **recp)
>+{
>+	struct efil_hdr *hdr =3D bloblist_find(BLOBLISTT_EFI_LOG, 0);
>+	struct efil_rec_hdr *rec_hdr;
>+	int ofs, size;
>+
>+	if (!hdr)
>+		return -ENOENT;
>+	size =3D str_size + sizeof(struct efil_rec_hdr);
>+	if (hdr->upto + size > hdr->size)
>+		return -ENOSPC;
>+
>+	rec_hdr =3D (void *)hdr + hdr->upto;
>+	rec_hdr->size =3D size;
>+	rec_hdr->tag =3D tag;
>+	rec_hdr->ended =3D false;
>+	*recp =3D rec_hdr + 1;
>+
>+	ofs =3D hdr->upto;
>+	hdr->upto +=3D size;
>+
>+	return ofs;
>+}
>+
>+/**
>+ * finish_rec() - Finish a previously started record
>+ *
>+ * @ofs: Offset of record to finish
>+ * @ret: Return code which is to be returned from the EFI function
>+ * Return: Pointer to the structure where the caller should add its data
>+ */
>+static void *finish_rec(int ofs, efi_status_t ret)
>+{
>+	struct efil_hdr *hdr =3D bloblist_find(BLOBLISTT_EFI_LOG, 0);
>+	struct efil_rec_hdr *rec_hdr;
>+
>+	if (!hdr || ofs < 0)
>+		return NULL;
>+	rec_hdr =3D (void *)hdr + ofs;
>+	rec_hdr->ended =3D true;
>+	rec_hdr->e_ret =3D ret;
>+
>+	return rec_hdr + 1;
>+}
>+
>+int efi_logs_testing(enum efil_test_t enum_val, efi_uintn_t int_val,
>+		     void *buffer, u64 *memory)
>+{
>+	struct efil_testing *rec;
>+	int ret;
>+
>+	ret =3D prep_rec(EFILT_TESTING, sizeof(*rec), (void **)&rec);
>+	if (ret < 0)
>+		return ret;
>+
>+	rec->int_val =3D int_val;
>+	rec->buffer =3D buffer;
>+	rec->memory =3D memory;
>+	rec->e_buffer =3D NULL;
>+	rec->e_memory =3D 0;
>+
>+	return ret;
>+}
>+
>+int efi_loge_testing(int ofs, efi_status_t efi_ret)
>+{
>+	struct efil_testing *rec;
>+
>+	rec =3D finish_rec(ofs, efi_ret);
>+	if (!rec)
>+		return -ENOSPC;
>+	rec->e_memory =3D *rec->memory;
>+	rec->e_buffer =3D *rec->buffer;
>+
>+	return 0;
>+}
>+
>+static void show_enum(const char *type_name[], int type)
>+{
>+	printf("%s ", type_name[type]);
>+}
>+
>+static void show_ulong(const char *prompt, ulong val)
>+{
>+	printf("%s %lx", prompt, val);
>+	if (val >=3D 10)
>+		printf("/%ld", val);
>+	printf(" ");
>+}
>+
>+static void show_addr(const char *prompt, ulong addr)
>+{
>+	printf("%s %lx ", prompt, addr);
>+}
>+
>+static void show_ret(efi_status_t ret)
>+{
>+	int code;
>+
>+	code =3D ret & ~EFI_ERROR_MASK;
>+	if (code < ARRAY_SIZE(error_name))
>+		printf("ret %s", error_name[ret]);
>+	else
>+		printf("ret %lx", ret);
>+}
>+
>+void show_rec(int seq, struct efil_rec_hdr *rec_hdr)
>+{
>+	void *start =3D (void *)rec_hdr + sizeof(struct efil_rec_hdr);
>+
>+	printf("%3d %12s ", seq, tag_name[rec_hdr->tag]);
>+	switch (rec_hdr->tag) {
>+	case EFILT_TESTING: {
>+		struct efil_testing *rec =3D start;
>+
>+		show_enum(test_enum_name, (int)rec->enum_val);
>+		show_ulong("int", (ulong)rec->int_val);
>+		show_addr("buf", map_to_sysmem(rec->buffer));
>+		show_addr("mem", map_to_sysmem(rec->memory));
>+		if (rec_hdr->ended) {
>+			show_addr("*buf",
>+				  (ulong)map_to_sysmem((void *)rec->e_buffer));
>+			show_addr("*mem",
>+				  (ulong)rec->e_memory);
>+			show_ret(rec_hdr->e_ret);
>+		}
>+	}
>+	case EFILT_COUNT:
>+		break;
>+	}
>+	printf("\n");
>+}
>+
>+int efi_log_show(void)
>+{
>+	struct efil_hdr *hdr =3D bloblist_find(BLOBLISTT_EFI_LOG, 0);
>+	struct efil_rec_hdr *rec_hdr;
>+	int i;
>+
>+	printf("EFI log (size %x)\n", hdr->upto);
>+	if (!hdr)
>+		return -ENOENT;
>+	for (i =3D 0, rec_hdr =3D (void *)hdr + sizeof(*hdr);
>+	     (void *)rec_hdr - (void *)hdr < hdr->upto;
>+	     i++, rec_hdr =3D (void *)rec_hdr + rec_hdr->size)
>+		show_rec(i, rec_hdr);
>+	printf("%d records\n", i);
>+
>+	return 0;
>+}
>+
>+int efi_log_reset(void)
>+{
>+	struct efil_hdr *hdr =3D bloblist_find(BLOBLISTT_EFI_LOG, 0);
>+
>+	if (!hdr)
>+		return -ENOENT;
>+	hdr->upto =3D sizeof(struct efil_hdr);
>+	hdr->size =3D CONFIG_EFI_LOG_SIZE;
>+
>+	return 0;
>+}
>+
>+int efi_log_init(void)
>+{
>+	struct efil_hdr *hdr;
>+
>+	hdr =3D bloblist_add(BLOBLISTT_EFI_LOG, CONFIG_EFI_LOG_SIZE, 0);
>+	if (!hdr) {
>+		/*
>+		 * Return -ENOMEM since we use -ENOSPC to mean that the log is
>+		 * full
>+		 */
>+		log_warning("Failed to setup EFI log\n");
>+		return log_msg_ret("eli", -ENOMEM);
>+	}
>+	efi_log_reset();
>+
>+	return 0;
>+}
