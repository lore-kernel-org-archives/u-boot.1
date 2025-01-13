Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574FBC02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 18:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97B34805DA;
	Mon, 13 Jan 2025 19:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="om5c4vtH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76C23805E9; Mon, 13 Jan 2025 19:23:21 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC98A801CF
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 19:23:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2efb17478adso7711758a91.1
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 10:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736792597; x=1737397397; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kK9Z/jtgBNOELDXrpfMdyH44b7kEkaH5khEU0KclI0E=;
 b=om5c4vtH5ax4uVWOTdvJYgiz+r/4tZd5yjyjgLbS1VJvJK1aFc8OfO3A3ShtjAEi6n
 H6WXVrJEixZQhqQWWjMGNl6U55IG+612sPk/5VANndpfmhr3jptbYNt8Za7hFmXOSx0r
 T4WYMFJkZNESjoYXEF+DChKpj5yrfwm8RUdfAnnEqXL2XvmAat6elvJiWAd2+odYViy9
 +gdgDZI9OQNp3cOopFYkH+BHldeSczGdOXj4lcgR1wChQi4mqjeDr6FKFM4aEEr3JEhC
 lOrI6gGvgQlZzW4J0rJOjHwqFSpDHClAJqoi/tNQwV/745lhLPdBxH07gGqDig+SGZVY
 ACPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736792597; x=1737397397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kK9Z/jtgBNOELDXrpfMdyH44b7kEkaH5khEU0KclI0E=;
 b=V0ozZo0C8fFMNSHbRsmtRcCNVP+hb5an+FPuHjjkzlyfguFTQFyZBM6Tyq8GUdQ2cG
 NZL/PvVGrjfNh6nfdBxsj/R5wlbUlFHNh0SZZgWV1g5L6wPCZ2Qvy4mnrIgO1TocyZEp
 WM98++TPCwxbLfnsDO957xB2yEbKK1+H3+ppQjKwYsPGlZcKceHwq5qBeYYY9oZM++jb
 tncBZbbsA6RzZujdohkzZ+TisXVHcJPDUt0u3jnZfB5qC7BbIOOOuyW86oWTiW4izuCQ
 rTQOWa7pqHj+aO+6HOLczP2+l6vBhUALH/FELN+q7fo7rdLe9FbeZayZ2OL73tbWb3Ba
 eIcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY39TQ8i+Un68cNNeij2VHXkcjLCQC89MDxwRiD+axOfHwnuIg7UQwMv5f8EIf6Cy3RMS/5+4=@lists.denx.de
X-Gm-Message-State: AOJu0YyBmvxBjfW6H0ZZrVCjAzpO33MPrkAZAyVZRxS/Vmy+UfKKanmX
 B6YquF2T1il3/i1ht/xPiN6W/+suAHhM/ccHLqdbzSqIGXjeV6HEKuoaoXbhzquRU81djZ62+Sn
 ybId3xH7y8z7XWR0gNrcDicvmXLAQ5lVg4EjVSQ==
X-Gm-Gg: ASbGnctqJatxUYWFLpTQQW6G18RARWK9LHK3mLG2NiPpRsqLvTCw1TEVQbyhAn/Yl5v
 2MrwSTCV4vu6PVdbf7cyYEOUPzNru8MxIiH1hCwhr8cfUQktihiH0JzV5ZZzGbG+7U93wog==
X-Google-Smtp-Source: AGHT+IGd5dqRsUYDoGbRsiO0vOvA9kYW0tr4b5ruyU5zTZbDeVddZ+02FlumsiM1s94UBj81ejbmedpvmpyrAwaDYVg=
X-Received: by 2002:a17:90b:2f0c:b0:2ee:7411:ca99 with SMTP id
 98e67ed59e1d1-2f548f09f6cmr28379904a91.1.1736792596994; Mon, 13 Jan 2025
 10:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20250110215640.892539-1-raymond.mao@linaro.org>
 <7DADDD00-D471-46D9-B143-00FBA1171ECB@gmx.de>
 <CAEfUkULM_Zh8fG22DWKjkbJ0QeP1dtbVa_=EF0c1FLE_Sr4QBg@mail.gmail.com>
 <208dab19-e178-41c9-bb18-3a534a510d46@gmx.de>
In-Reply-To: <208dab19-e178-41c9-bb18-3a534a510d46@gmx.de>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 13 Jan 2025 13:23:07 -0500
X-Gm-Features: AbW1kvas4MsBiKlnEvk_FtbnRm3XcIxwv1lQ5XxtFusLMrX_8v7V3MXa0mKoeIE
Message-ID: <CAEfUkUKt2vHL2xRjzw5ase-633hm3PBw+nM=30985XujSmkMsQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] bloblist: add api to get blob with size
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
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

On Mon, 13 Jan 2025 at 12:50, Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:

> On 13.01.25 15:33, Raymond Mao wrote:
> > Hi Heinrich,
> >
> > On Fri, 10 Jan 2025 at 19:04, Heinrich Schuchardt <xypron.glpk@gmx.de
> > <mailto:xypron.glpk@gmx.de>> wrote:
> >
> >     Am 10. Januar 2025 22:56:33 MEZ schrieb Raymond Mao
> >     <raymond.mao@linaro.org <mailto:raymond.mao@linaro.org>>:
> >      >bloblist_find function only returns the pointer of blob data,
> >      >which is fine for those self-describing data like FDT.
> >      >But as a common scenario, an interface is needed to retrieve both
> >      >the pointer and the size of the blob data.
> >      >
> >      >Add a few ut test cases for the new api.
> >      >
> >      >Signed-off-by: Raymond Mao <raymond.mao@linaro.org
> >     <mailto:raymond.mao@linaro.org>>
> >      >Reviewed-by: Simon Glass <sjg@chromium.org <mailto:
> sjg@chromium.org>>
> >      >Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org
> >     <mailto:ilias.apalodimas@linaro.org>>
> >      >---
> >      >Changes in v2
> >      >- Rename function argument.
> >      >- Add ut tests.
> >      >Changes in v3
> >      >- None.
> >      >Changes in v4
> >      >- None.
> >      >
> >      > common/bloblist.c      | 17 +++++++++++++++--
> >      > include/bloblist.h     | 18 ++++++++++++++++++
> >      > test/common/bloblist.c |  4 ++++
> >      > 3 files changed, 37 insertions(+), 2 deletions(-)
> >      >
> >      >diff --git a/common/bloblist.c b/common/bloblist.c
> >      >index 110bb9dc44..ab48a3cdb9 100644
> >      >--- a/common/bloblist.c
> >      >+++ b/common/bloblist.c
> >      >@@ -222,14 +222,27 @@ static int bloblist_ensurerec(uint tag,
> >     struct bloblist_rec **recp, int size,
> >      > }
> >      >
> >      > void *bloblist_find(uint tag, int size)
> >      >+{
> >      >+      void *blob = NULL;
> >      >+      int blob_size;
> >      >+
> >      >+      blob = bloblist_get_blob(tag, &blob_size);
> >      >+
> >      >+      if (size && size != blob_size)
> >      >+              return NULL;
> >      >+
> >      >+      return blob;
> >      >+}
> >      >+
> >      >+void *bloblist_get_blob(uint tag, int *sizep)
> >      > {
> >      >       struct bloblist_rec *rec;
> >      >
> >      >       rec = bloblist_findrec(tag);
> >      >       if (!rec)
> >      >               return NULL;
> >      >-      if (size && size != rec->size)
> >      >-              return NULL;
> >      >+
> >      >+      *sizep = rec->size;
> >      >
> >      >       return (void *)rec + rec_hdr_size(rec);
> >      > }
> >      >diff --git a/include/bloblist.h b/include/bloblist.h
> >      >index f999391f74..52ba0ddcf8 100644
> >      >--- a/include/bloblist.h
> >      >+++ b/include/bloblist.h
> >      >@@ -250,6 +250,24 @@ static inline void
> >     *bloblist_check_magic(ulong addr)
> >      >       return ptr;
> >      > }
> >      >
> >      >+#if CONFIG_IS_ENABLED(BLOBLIST)
> >
> >     Why should we use an #ifdef here?
> >     Why would a caller invoke the function if the configuration is
> disabled?
> >
> > Adding #ifdef here is to have the inline function so that we don't need
> > to add the macro to all of its callers.
>
> There is just one. See patch 3, where you already check the CONFIG
> albeit in the wrong place.
>
>
Currently it is only one for TPM eventlog, but according to the Firmware
Handoff spec we will use Transfer List (aka bloblist in U-Boot) to handover
different information (blobs) from previous boot stage, so that we will
need to call bloblist_get_blob in multiple subsystems in the near future.

In patch #3, checking BLOBLIST is a temporary solution since we don't have
a good idea at the moment on a required config to enable/disable "handoff
from previous boot stage using bloblist" -  which is separate from BLOBLIST
itself.
As discussed with Tom, I use BLOBLIST as a temporary solution but this will
be replaced in the future.

See my reply in patch #3 for more information.

Regards,
Raymond


> >
> >      >+/**
> >      >+ * bloblist_get_blob() - Find a blob and get the size of it
> >      >+ *
> >      >+ * Searches the bloblist and returns the blob with the matching
> tag
> >      >+ *
> >      >+ * @tag:      Tag to search for (enum bloblist_tag_t)
> >      >+ * @sizep:    Size of the blob found
> >      >+ * Return: pointer to bloblist if found, or NULL if not found
> >      >+ */
> >      >+void *bloblist_get_blob(uint tag, int *sizep);
> >
> >     If tag is expected to be a value from the enum, we should not use
> >     uint here.
> >
> > This is just following the original convention of existing bloblist
> > functions which are all using uint for the tag.
>
> @Simon: Why aren't we using enum?
>
> Best regards
>
> Heinrich
>
> >
> > Regards,
> > Raymond
> >
> >
> >      >+#else
> >      >+static inline void *bloblist_get_blob(uint tag, int *sizep)
> >      >+{
> >      >+      return NULL;
> >      >+}
> >      >+#endif
> >      >+
> >      > /**
> >      >  * bloblist_find() - Find a blob
> >      >  *
> >      >diff --git a/test/common/bloblist.c b/test/common/bloblist.c
> >      >index 4bca62110a..324127596f 100644
> >      >--- a/test/common/bloblist.c
> >      >+++ b/test/common/bloblist.c
> >      >@@ -98,10 +98,12 @@ static int bloblist_test_blob(struct
> >     unit_test_state *uts)
> >      >       struct bloblist_hdr *hdr;
> >      >       struct bloblist_rec *rec, *rec2;
> >      >       char *data;
> >      >+      int size = 0;
> >      >
> >      >       /* At the start there should be no records */
> >      >       hdr = clear_bloblist();
> >      >       ut_assertnull(bloblist_find(TEST_TAG, TEST_BLOBLIST_SIZE));
> >      >+      ut_assertnull(bloblist_get_blob(TEST_TAG, &size));
> >      >       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0,
> 0));
> >      >       ut_asserteq(sizeof(struct bloblist_hdr),
> bloblist_get_size());
> >      >       ut_asserteq(TEST_BLOBLIST_SIZE, bloblist_get_total_size());
> >      >@@ -114,6 +116,8 @@ static int bloblist_test_blob(struct
> >     unit_test_state *uts)
> >      >       ut_asserteq_addr(rec + 1, data);
> >      >       data = bloblist_find(TEST_TAG, TEST_SIZE);
> >      >       ut_asserteq_addr(rec + 1, data);
> >      >+      ut_asserteq_addr(bloblist_get_blob(TEST_TAG, &size), data);
> >      >+      ut_asserteq(size, TEST_SIZE);
> >      >
> >      >       /* Check the data is zeroed */
> >      >       ut_assertok(check_zero(data, TEST_SIZE));
> >
>
>
