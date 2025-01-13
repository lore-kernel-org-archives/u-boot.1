Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15704C02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 17:50:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4459A805DA;
	Mon, 13 Jan 2025 18:50:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qNb8R9eF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE51F805E9; Mon, 13 Jan 2025 18:50:37 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90E41801CF
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 18:50:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736790632; x=1737395432; i=xypron.glpk@gmx.de;
 bh=0KyuTCUf1PHyMDIodG5QCsA4yYf8Jdl8ZWJX6HHP6yA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qNb8R9eFDclfNrYOb51bc8wIWW0/S/+71vjudRBKTPp4accSwSikkok12Jl9TDUc
 uf/c0F/9rhRizmOb1yZhQP3weorOr3oenRfZ+1bhcZyiLbKyOK/8Y+FZwVXYY8nRY
 zg2Lu6/2RhNvO9mNr4+pSIQNrzAp6SPUgSFw6zU28SkvT4yoy+/JboFM7z0XxZPqS
 ZCNR/VltAQ571jQRhKSNPRq/O3Xfn24/mCF8pBBxrSweC1ILrFex4W1wmB9rYT00A
 f5dkR6w6VC2gcY4RzLuP8a5Y3SxdHYHuDaLatYzLvktFtjlUi5xUNTNlgKHbbDf2v
 bawv2WF42hQx2glXJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeMG-1twfC006Q0-00QlnW; Mon, 13
 Jan 2025 18:50:32 +0100
Message-ID: <208dab19-e178-41c9-bb18-3a534a510d46@gmx.de>
Date: Mon, 13 Jan 2025 18:50:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] bloblist: add api to get blob with size
To: Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>
References: <20250110215640.892539-1-raymond.mao@linaro.org>
 <7DADDD00-D471-46D9-B143-00FBA1171ECB@gmx.de>
 <CAEfUkULM_Zh8fG22DWKjkbJ0QeP1dtbVa_=EF0c1FLE_Sr4QBg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAEfUkULM_Zh8fG22DWKjkbJ0QeP1dtbVa_=EF0c1FLE_Sr4QBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qF7nA6AReVA4drjXY/PwWblFGshVoYnXk3Tf6qrPt+TjAzzcRsG
 zCaZ7BZJ13qjbK1VLLsatPxMeOP3oJAG2CrFHedoAkFw2rBG5H3gkAVGeHZ4phcHRAY/5Ct
 JU1j8UpHQvG+3OVLIH8SLYTQzk99/aZTQAmU30jKr2Z7RL4WdaanwvoFVHrGV6hVybWZTmr
 YbpA6k+GzdhsDXTEyhfYw==
UI-OutboundReport: notjunk:1;M01:P0:kEN3lIfcBHo=;bTn/CbLJRLWUkkqosPbxBwd9b/i
 +kwilBPeIUA6UM6gb1pT7jWWA9cTQYeWgoltWDHuQBC5t5oX6SZE1Yx4BbX4pxwPnaTLIujdm
 Jn9rAJh9QyVgKj8ZLF2bmlzQvi1kdOr32073AEO+gzhp45dTStv9MPOlYBTWI4BJ50+oLRh1r
 ZioDdyXUYUfi6x0uEQI5zEt9JiCp0MwpxiFZLWFY2t+hK283HbVpOzLIufKYbSNWT4x061TE+
 ByijKJZL95lCUKCfEY6YwWNk1F317iQM54eVqFnTo+VuEeHUVgRYH/+LUG3esBxbiyBV8007U
 U5CMeUc4QgfrfTiF3qc+9zzZaLq8fwRfHEvYaIfckeedRYodO+YY5DDigknPGiixbqUo/BPkV
 BkE/3mroayCnyCynRKlTcfAs0/Dekj9p1YfqBZh7PxykDkfhsicHy7aIRthmZ0RP5P+Df+DsT
 tpdoLLbnCSm2NXQnRfjt7+MLKKv1dXFqd2W8UkXzSUe96BwBWRmVxn6YlSmNN0nhmFLeeu4+L
 51IeI0kKFJ/4idaSUZ07OwlzjNuw0Wjkx7KZsE0sq3fA3DT0Bg5TYFk1LBSm/jzxvefot8LlE
 jHg1tMFKzD2aWUTuU8mdA5jMktOZDacKEgKL85pxcbi5wU2s8doRBfYhtqjDlNFwY0RO3rVPM
 sx9nCJLc1ad1dAE2+5KPf8EwR/7qzHLtQFMwdZRpJ+k4GYS7ng3gd1q6cndtDkl9Oai/bDFJg
 NpsA/bmwxWwCXUYiWe5q9LihHtvpatpXAIzR7LQ1WuwrQ5Y61FtdPVieJQrMqucb6IJXZbG1F
 XWICzCQ6lc23h3dnGm6p4dCmOG0a4y7I9Qrun0sM4jzUQe7x42ROr42+GMdSN2ZBBCnPRxIsT
 TP7iUoWi9e1YNXFh6F3qgvOqytoHxd6cymo1ciL+rf2sn9pqfKvuB7NDC3/Lr6HI679mX4XH5
 jVyoBx+BXQGv5OPa0YESj723Iey8KGqj9XGytCBscbQ8CuJsCIHaM3wwiJXaj5bYIxeXGLmkg
 cC2ZE1gm2oXbgcjMJr6zGm1Br/SqNkmaXzcHLufC+EdwhZ4xcgPCywWF5itkjaGrKfKeNiuuz
 RxZCP90EaQUiY9FcuK/9q6MZ8In6JH
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

On 13.01.25 15:33, Raymond Mao wrote:
> Hi=C2=A0Heinrich,
>
> On Fri, 10 Jan 2025 at 19:04, Heinrich Schuchardt <xypron.glpk@gmx.de
> <mailto:xypron.glpk@gmx.de>> wrote:
>
>     Am 10. Januar 2025 22:56:33 MEZ schrieb Raymond Mao
>     <raymond.mao@linaro.org <mailto:raymond.mao@linaro.org>>:
>      >bloblist_find function only returns the pointer of blob data,
>      >which is fine for those self-describing data like FDT.
>      >But as a common scenario, an interface is needed to retrieve both
>      >the pointer and the size of the blob data.
>      >
>      >Add a few ut test cases for the new api.
>      >
>      >Signed-off-by: Raymond Mao <raymond.mao@linaro.org
>     <mailto:raymond.mao@linaro.org>>
>      >Reviewed-by: Simon Glass <sjg@chromium.org <mailto:sjg@chromium.or=
g>>
>      >Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org
>     <mailto:ilias.apalodimas@linaro.org>>
>      >---
>      >Changes in v2
>      >- Rename function argument.
>      >- Add ut tests.
>      >Changes in v3
>      >- None.
>      >Changes in v4
>      >- None.
>      >
>      > common/bloblist.c=C2=A0 =C2=A0 =C2=A0 | 17 +++++++++++++++--
>      > include/bloblist.h=C2=A0 =C2=A0 =C2=A0| 18 ++++++++++++++++++
>      > test/common/bloblist.c |=C2=A0 4 ++++
>      > 3 files changed, 37 insertions(+), 2 deletions(-)
>      >
>      >diff --git a/common/bloblist.c b/common/bloblist.c
>      >index 110bb9dc44..ab48a3cdb9 100644
>      >--- a/common/bloblist.c
>      >+++ b/common/bloblist.c
>      >@@ -222,14 +222,27 @@ static int bloblist_ensurerec(uint tag,
>     struct bloblist_rec **recp, int size,
>      > }
>      >
>      > void *bloblist_find(uint tag, int size)
>      >+{
>      >+=C2=A0 =C2=A0 =C2=A0 void *blob =3D NULL;
>      >+=C2=A0 =C2=A0 =C2=A0 int blob_size;
>      >+
>      >+=C2=A0 =C2=A0 =C2=A0 blob =3D bloblist_get_blob(tag, &blob_size);
>      >+
>      >+=C2=A0 =C2=A0 =C2=A0 if (size && size !=3D blob_size)
>      >+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>      >+
>      >+=C2=A0 =C2=A0 =C2=A0 return blob;
>      >+}
>      >+
>      >+void *bloblist_get_blob(uint tag, int *sizep)
>      > {
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bloblist_rec *rec;
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0rec =3D bloblist_findrec(tag);
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rec)
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL=
;
>      >-=C2=A0 =C2=A0 =C2=A0 if (size && size !=3D rec->size)
>      >-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>      >+
>      >+=C2=A0 =C2=A0 =C2=A0 *sizep =3D rec->size;
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0return (void *)rec + rec_hdr_size(rec);
>      > }
>      >diff --git a/include/bloblist.h b/include/bloblist.h
>      >index f999391f74..52ba0ddcf8 100644
>      >--- a/include/bloblist.h
>      >+++ b/include/bloblist.h
>      >@@ -250,6 +250,24 @@ static inline void
>     *bloblist_check_magic(ulong addr)
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0return ptr;
>      > }
>      >
>      >+#if CONFIG_IS_ENABLED(BLOBLIST)
>
>     Why should we use an #ifdef here?
>     Why would a caller invoke the function if the configuration is disab=
led?
>
> Adding #ifdef here is to have the inline function so that we don't need
> to add the macro to all of its callers.

There is just one. See patch 3, where you already check the CONFIG
albeit in the wrong place.

>
>      >+/**
>      >+ * bloblist_get_blob() - Find a blob and get the size of it
>      >+ *
>      >+ * Searches the bloblist and returns the blob with the matching t=
ag
>      >+ *
>      >+ * @tag:=C2=A0 =C2=A0 =C2=A0 Tag to search for (enum bloblist_tag=
_t)
>      >+ * @sizep:=C2=A0 =C2=A0 Size of the blob found
>      >+ * Return: pointer to bloblist if found, or NULL if not found
>      >+ */
>      >+void *bloblist_get_blob(uint tag, int *sizep);
>
>     If tag is expected to be a value from the enum, we should not use
>     uint here.
>
> This is just following the original convention of existing bloblist
> functions which are all using=C2=A0uint for the tag.

@Simon: Why aren't we using enum?

Best regards

Heinrich

>
> Regards,
> Raymond
>
>
>      >+#else
>      >+static inline void *bloblist_get_blob(uint tag, int *sizep)
>      >+{
>      >+=C2=A0 =C2=A0 =C2=A0 return NULL;
>      >+}
>      >+#endif
>      >+
>      > /**
>      >=C2=A0 * bloblist_find() - Find a blob
>      >=C2=A0 *
>      >diff --git a/test/common/bloblist.c b/test/common/bloblist.c
>      >index 4bca62110a..324127596f 100644
>      >--- a/test/common/bloblist.c
>      >+++ b/test/common/bloblist.c
>      >@@ -98,10 +98,12 @@ static int bloblist_test_blob(struct
>     unit_test_state *uts)
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bloblist_hdr *hdr;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0struct bloblist_rec *rec, *rec2;
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0char *data;
>      >+=C2=A0 =C2=A0 =C2=A0 int size =3D 0;
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0/* At the start there should be no reco=
rds */
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0hdr =3D clear_bloblist();
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_assertnull(bloblist_find(TEST_TAG, T=
EST_BLOBLIST_SIZE));
>      >+=C2=A0 =C2=A0 =C2=A0 ut_assertnull(bloblist_get_blob(TEST_TAG, &s=
ize));
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_assertok(bloblist_new(TEST_ADDR, TES=
T_BLOBLIST_SIZE, 0, 0));
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_asserteq(sizeof(struct bloblist_hdr)=
, bloblist_get_size());
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_asserteq(TEST_BLOBLIST_SIZE, bloblis=
t_get_total_size());
>      >@@ -114,6 +116,8 @@ static int bloblist_test_blob(struct
>     unit_test_state *uts)
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_asserteq_addr(rec + 1, data);
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D bloblist_find(TEST_TAG, TEST_S=
IZE);
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_asserteq_addr(rec + 1, data);
>      >+=C2=A0 =C2=A0 =C2=A0 ut_asserteq_addr(bloblist_get_blob(TEST_TAG,=
 &size), data);
>      >+=C2=A0 =C2=A0 =C2=A0 ut_asserteq(size, TEST_SIZE);
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check the data is zeroed */
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0ut_assertok(check_zero(data, TEST_SIZE)=
);
>

