Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2749FC02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 14:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2261B801CF;
	Mon, 13 Jan 2025 15:33:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p8JkpkA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 976EF805DA; Mon, 13 Jan 2025 15:33:46 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 003E080141
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 15:33:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ee46851b5eso5824616a91.1
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 06:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736778822; x=1737383622; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zPWzLfVOlhVSyfRxuoYHAaN3KnosgXa5XGu2tP5JihQ=;
 b=p8JkpkA/hXL8tsbMkXgN7CBx2xXajrkmRTjhcLvDzmoG9y2Vf/wuPT/NlS1YmgX3kx
 /UWyUqG8zrkx6XgxMi9Um+sFHX+vW0d6AMOvxvprXtir2xyIfwK7dmr0LdFjftXJBW0P
 X9Mcxfu02zLNv+gcNJRlt8yBg26U0KgqkuZriB0jC3SJvTWgIdqWpjOgPdjT9xurMkZJ
 EitSBgSzwcBjnVisbpfT3v5jdhTqsqTC1BSaTMHZkObl1Uzh2lbrRJVVhi7AS1o2VA9d
 r/yipvzCa4+NRIPijyL5M9omH/XwNOnwzwVe3xsf3i9D+YRaixPPRFW7iZ6dJJqSVxFq
 L2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736778822; x=1737383622;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zPWzLfVOlhVSyfRxuoYHAaN3KnosgXa5XGu2tP5JihQ=;
 b=Qxllu2K9LOVdSNG9WSZoZxqNk51OmUnhL4HOC8r8AMSBSQ4u9TWFndTaqBEMOFqre/
 LEnr9r1022+E5GoR/Ylic7n8Dak1gdN+Po+Xx30mLZUsNLCedRQfur0TXSMh6ahXiKpD
 hMg4n4Z2SOOsDafc2AVXj8XyvmQLwZPUTRcI3jQKvgx96zuwRQ8qrClnEM3GbP/AB/vK
 H6jf++HkvgH9FrlFg2MPBa8BDivRYBiTD4eHeqtpXz0/0bPNBD3HFTrF5tdavasWv5NC
 nzuSMDiQ3sOF8zZUINfcGhQA93vQJneuoUT0W/wyVf6tTbejTRG96H77eFkABq5iiYhL
 CSQw==
X-Gm-Message-State: AOJu0Yz21I0JCwbOwOsRgHZTSOU4nAFXNqguKKpUITa97zvpg2mllD/I
 185WDQ7+Ceyrdw1l9wWJ7oIORl1WZ2RXZ+aRfSk/clUdr7OULyKvbj5J5ZbZ1E9RKF8kk4riiYw
 HwxBNv9+xiyFbk3m8py0lnSEd1GRmCSabgAbsvw==
X-Gm-Gg: ASbGnctp926K/ICq7t3hAY1RCbiM6ilqmrBbdRXGeJiB3NwL7BbX3wOM4Izw8JdXpLH
 +j0gD7bc7kd3bmKXGUejfw53m6A6ngJzQOarSh1FiqDP3/Q9FVyGgQ1PGepVLy6U36iXg0w==
X-Google-Smtp-Source: AGHT+IFK5x8CkzyOxR7Jys3D2P/mGyTi0tHtpfe3bYRl7RCOZG9PE8/NhndrC1PjVFuaAIxYca8xYNvYF7mNM+6lNho=
X-Received: by 2002:a17:90a:dfc7:b0:2f2:a664:df33 with SMTP id
 98e67ed59e1d1-2f548ea60c8mr27221229a91.1.1736778822398; Mon, 13 Jan 2025
 06:33:42 -0800 (PST)
MIME-Version: 1.0
References: <20250110215640.892539-1-raymond.mao@linaro.org>
 <7DADDD00-D471-46D9-B143-00FBA1171ECB@gmx.de>
In-Reply-To: <7DADDD00-D471-46D9-B143-00FBA1171ECB@gmx.de>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 13 Jan 2025 09:33:32 -0500
X-Gm-Features: AbW1kvZLkLFLxq63AkpjOsabXVYBBtmrjbqEq6P0XFpCHz8jdXZ7AZgwvylJLfw
Message-ID: <CAEfUkULM_Zh8fG22DWKjkbJ0QeP1dtbVa_=EF0c1FLE_Sr4QBg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] bloblist: add api to get blob with size
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Levi Yun <yeoreum.yun@arm.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Heinrich,

On Fri, 10 Jan 2025 at 19:04, Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:

> Am 10. Januar 2025 22:56:33 MEZ schrieb Raymond Mao <
> raymond.mao@linaro.org>:
> >bloblist_find function only returns the pointer of blob data,
> >which is fine for those self-describing data like FDT.
> >But as a common scenario, an interface is needed to retrieve both
> >the pointer and the size of the blob data.
> >
> >Add a few ut test cases for the new api.
> >
> >Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >Reviewed-by: Simon Glass <sjg@chromium.org>
> >Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >---
> >Changes in v2
> >- Rename function argument.
> >- Add ut tests.
> >Changes in v3
> >- None.
> >Changes in v4
> >- None.
> >
> > common/bloblist.c      | 17 +++++++++++++++--
> > include/bloblist.h     | 18 ++++++++++++++++++
> > test/common/bloblist.c |  4 ++++
> > 3 files changed, 37 insertions(+), 2 deletions(-)
> >
> >diff --git a/common/bloblist.c b/common/bloblist.c
> >index 110bb9dc44..ab48a3cdb9 100644
> >--- a/common/bloblist.c
> >+++ b/common/bloblist.c
> >@@ -222,14 +222,27 @@ static int bloblist_ensurerec(uint tag, struct
> bloblist_rec **recp, int size,
> > }
> >
> > void *bloblist_find(uint tag, int size)
> >+{
> >+      void *blob = NULL;
> >+      int blob_size;
> >+
> >+      blob = bloblist_get_blob(tag, &blob_size);
> >+
> >+      if (size && size != blob_size)
> >+              return NULL;
> >+
> >+      return blob;
> >+}
> >+
> >+void *bloblist_get_blob(uint tag, int *sizep)
> > {
> >       struct bloblist_rec *rec;
> >
> >       rec = bloblist_findrec(tag);
> >       if (!rec)
> >               return NULL;
> >-      if (size && size != rec->size)
> >-              return NULL;
> >+
> >+      *sizep = rec->size;
> >
> >       return (void *)rec + rec_hdr_size(rec);
> > }
> >diff --git a/include/bloblist.h b/include/bloblist.h
> >index f999391f74..52ba0ddcf8 100644
> >--- a/include/bloblist.h
> >+++ b/include/bloblist.h
> >@@ -250,6 +250,24 @@ static inline void *bloblist_check_magic(ulong addr)
> >       return ptr;
> > }
> >
> >+#if CONFIG_IS_ENABLED(BLOBLIST)
>
> Why should we use an #ifdef here?
> Why would a caller invoke the function if the configuration is disabled?
>
> Adding #ifdef here is to have the inline function so that we don't need to
add the macro to all of its callers.


> >+/**
> >+ * bloblist_get_blob() - Find a blob and get the size of it
> >+ *
> >+ * Searches the bloblist and returns the blob with the matching tag
> >+ *
> >+ * @tag:      Tag to search for (enum bloblist_tag_t)
> >+ * @sizep:    Size of the blob found
> >+ * Return: pointer to bloblist if found, or NULL if not found
> >+ */
> >+void *bloblist_get_blob(uint tag, int *sizep);
>
> If tag is expected to be a value from the enum, we should not use uint
> here.
>
> This is just following the original convention of existing bloblist
functions which are all using uint for the tag.

Regards,
Raymond


> >+#else
> >+static inline void *bloblist_get_blob(uint tag, int *sizep)
> >+{
> >+      return NULL;
> >+}
> >+#endif
> >+
> > /**
> >  * bloblist_find() - Find a blob
> >  *
> >diff --git a/test/common/bloblist.c b/test/common/bloblist.c
> >index 4bca62110a..324127596f 100644
> >--- a/test/common/bloblist.c
> >+++ b/test/common/bloblist.c
> >@@ -98,10 +98,12 @@ static int bloblist_test_blob(struct unit_test_state
> *uts)
> >       struct bloblist_hdr *hdr;
> >       struct bloblist_rec *rec, *rec2;
> >       char *data;
> >+      int size = 0;
> >
> >       /* At the start there should be no records */
> >       hdr = clear_bloblist();
> >       ut_assertnull(bloblist_find(TEST_TAG, TEST_BLOBLIST_SIZE));
> >+      ut_assertnull(bloblist_get_blob(TEST_TAG, &size));
> >       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
> >       ut_asserteq(sizeof(struct bloblist_hdr), bloblist_get_size());
> >       ut_asserteq(TEST_BLOBLIST_SIZE, bloblist_get_total_size());
> >@@ -114,6 +116,8 @@ static int bloblist_test_blob(struct unit_test_state
> *uts)
> >       ut_asserteq_addr(rec + 1, data);
> >       data = bloblist_find(TEST_TAG, TEST_SIZE);
> >       ut_asserteq_addr(rec + 1, data);
> >+      ut_asserteq_addr(bloblist_get_blob(TEST_TAG, &size), data);
> >+      ut_asserteq(size, TEST_SIZE);
> >
> >       /* Check the data is zeroed */
> >       ut_assertok(check_zero(data, TEST_SIZE));
>
>
