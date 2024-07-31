Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CE4C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 06:21:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 926468896C;
	Wed, 31 Jul 2024 08:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="uGuC3hDZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB4A28890F; Wed, 31 Jul 2024 08:21:35 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C06C28889C
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 08:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1722406892; x=1723011692; i=xypron.glpk@gmx.de;
 bh=+pYHYs7bQhYUSXRpMmU951NePF30tYs0xYBnHv8Wi4U=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=uGuC3hDZ//08lzvIo1z3hpm9oJAy+SgvBjiBzxyN6XmTmIxbTpyrPzWgfGXfEGMW
 Ll9Xot22CScL5yziYPmtilvaMyDc5l8u4o7t+TMRCgOCsaeN5Io7hSQdJiJGpOvxi
 cxlXOjT7PjACd2yoMRmopyEoe2aIQIA1ajlqBHDBOgYJeF22jcd92xUXtwGYbGU7a
 0n59h+jEt88/+/OYYS7amzINTwYfAClLmNnQNeZMioOojslABg8Tg0LbjEoe9I1yW
 bFnCJpnTchXHBSZ7BagX6ta2NMV+JpxNDAh5gFeD+imYVhBCX2Cn9BBeOK8zJn/iv
 FN1zKwIGLFlRcThmGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQXN-1sI3Yn2fDB-010RA9; Wed, 31
 Jul 2024 08:21:32 +0200
Message-ID: <10fd2ecd-fe6d-4ab8-b10d-722ef712dc2c@gmx.de>
Date: Wed, 31 Jul 2024 08:21:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] efi_memory: get the efi_mem_list node directly
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
 <20240730111132.1097315-4-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240730111132.1097315-4-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ARdphSv8UgC+stLHlaMQd1MLAnG/1Uuc6+uaXds9m8TOp+fJEAl
 Slwc3SQq6Ewf21pE64Wn9S5wkFYDNPnByq8XImojkCQlXmZ+0mEDzyv4aaQJH+yT7fL1hhU
 OTD5AuVrGIvc2hs3FoI2x8ZKibQolTGNzDrfIwjkB2GJVEEOdzRqFaGRtoQr75Lbpr7YXn3
 0x1HpGg5ZUceH3If1Tzeg==
UI-OutboundReport: notjunk:1;M01:P0:7iKF9s3Lm0U=;cl22Y9kLNcGd4TqSebeVYlRfJ5n
 vDmguta7Oye27priflu1pW+Ronm/XCCLZYt0bqzHPJuqkQK+9YSDEMMRiuwIIhaBo7YXBKpCs
 RCMbzwpBivIUUDt1VDeioRzYXu/KFW1CFBADCt3lmv27DKmg9ah5KAf+PlzpaRDRm7s0MCAOv
 yy1eXxIm3Rpb0DxSgrjz4OwP7QHlhFso62peE7+7QS/S3nemLXyubiBC9O3+StCIMFc0xvYaB
 cpOWmUdAiOAyLDaJpevKBZxhfoZlOkqAos96aZg+emTIPkHZAGxr9Aa5/3dHcSjGdlGGV68vJ
 vwdng1XCG5g6MlZBMWvfzyIcToIDV/GXGwmGp4MD6BCtXzqGx3UmLJ/MuUdzTBOvoF/Zd/49B
 /Vj/2r1iEnWkTb0jE1Uu5G7P4dUqJ1APk7D8GhIOhxdd+iebdOqPTig66wZkjxfiBTAzyXgRk
 4NAow3Q9fVmKwC+L+Jrd0U7NWAO34nRQpEqx9hj2aOYVTfwZ4xMaPnnqNaQWfkrTy2w8A99lY
 i/8HzP7pCUWItUyE5nPcwrZsIW3C6VabWbA7/QYTNRDXUq+d08gFgryMIIRAR6k6c8OkxdjZT
 joWfSAZkLtuX+zVI6IHou+L8qtSzMN6QLY0mRCcEMAdE3E3b1KiMFO6JqJKEkGRBUFI5dbGPz
 PmJRZEbDQyxV4QUpfsiTnTrhcxMfa48TREL/QXdJ9QTIXqNqiU9YP7UA3tGItyhJME43tC9M4
 mgr9CtsqssPJpru90S5s+A+25TnYhBQWSojEhxo39+QvCvCgft5JvWJB8pVYG1LeTZdtHCOhJ
 54BSpAgOqYoRsHLWKFurgc+A==
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

On 7/30/24 13:11, Sughosh Ganu wrote:
> Use the list_for_each_entry() API to get the efi_mem_list node
> directly, instead of making an additional call to list_entry().
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_loader/efi_memory.c | 25 ++++++++-----------------
>   1 file changed, 8 insertions(+), 17 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 8d4f6e339d..6819c2ec90 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -127,7 +127,7 @@ static uint64_t desc_get_end(struct efi_mem_desc *de=
sc)
>    */
>   static void efi_mem_sort(void)
>   {
> -	struct list_head *lhandle;
> +	struct efi_mem_list *lmem;
>   	struct efi_mem_list *prevmem =3D NULL;
>   	bool merge_again =3D true;
>
> @@ -136,13 +136,11 @@ static void efi_mem_sort(void)
>   	/* Now merge entries that can be merged */
>   	while (merge_again) {
>   		merge_again =3D false;
> -		list_for_each(lhandle, &efi_mem) {
> -			struct efi_mem_list *lmem;
> +		list_for_each_entry(lmem, &efi_mem, link) {
>   			struct efi_mem_desc *prev;
>   			struct efi_mem_desc *cur;
>   			uint64_t pages;
>
> -			lmem =3D list_entry(lhandle, struct efi_mem_list, link);
>   			if (!prevmem) {
>   				prevmem =3D lmem;
>   				continue;
> @@ -269,7 +267,7 @@ static efi_status_t efi_add_memory_map_pg(u64 start,=
 u64 pages,
>   					  int memory_type,
>   					  bool overlap_only_ram)
>   {
> -	struct list_head *lhandle;
> +	struct efi_mem_list *lmem;
>   	struct efi_mem_list *newlist;
>   	bool carve_again;
>   	uint64_t carved_pages =3D 0;
> @@ -309,11 +307,9 @@ static efi_status_t efi_add_memory_map_pg(u64 start=
, u64 pages,
>   	/* Add our new map */
>   	do {
>   		carve_again =3D false;
> -		list_for_each(lhandle, &efi_mem) {
> -			struct efi_mem_list *lmem;
> +		list_for_each_entry(lmem, &efi_mem, link) {
>   			s64 r;
>
> -			lmem =3D list_entry(lhandle, struct efi_mem_list, link);
>   			r =3D efi_mem_carve_out(lmem, &newlist->desc,
>   					      overlap_only_ram);
>   			switch (r) {
> @@ -445,7 +441,7 @@ static efi_status_t efi_check_allocated(u64 addr, bo=
ol must_be_allocated)
>    */
>   static uint64_t efi_find_free_memory(uint64_t len, uint64_t max_addr)
>   {
> -	struct list_head *lhandle;
> +	struct efi_mem_list *lmem;
>
>   	/*
>   	 * Prealign input max address, so we simplify our matching
> @@ -453,9 +449,7 @@ static uint64_t efi_find_free_memory(uint64_t len, u=
int64_t max_addr)
>   	 */
>   	max_addr &=3D ~EFI_PAGE_MASK;
>
> -	list_for_each(lhandle, &efi_mem) {
> -		struct efi_mem_list *lmem =3D list_entry(lhandle,
> -			struct efi_mem_list, link);
> +	list_for_each_entry(lmem, &efi_mem, link) {
>   		struct efi_mem_desc *desc =3D &lmem->desc;
>   		uint64_t desc_len =3D desc->num_pages << EFI_PAGE_SHIFT;
>   		uint64_t desc_end =3D desc->physical_start + desc_len;
> @@ -745,7 +739,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_=
map_size,
>   {
>   	int map_entries;
>   	efi_uintn_t map_size =3D 0;
> -	struct list_head *lhandle;
> +	struct efi_mem_list *lmem;
>   	efi_uintn_t provided_map_size;
>
>   	if (!memory_map_size)
> @@ -774,10 +768,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory=
_map_size,
>   	/* Copy list into array */
>   	/* Return the list in ascending order */
>   	memory_map =3D &memory_map[map_entries - 1];
> -	list_for_each(lhandle, &efi_mem) {
> -		struct efi_mem_list *lmem;
> -
> -		lmem =3D list_entry(lhandle, struct efi_mem_list, link);
> +	list_for_each_entry(lmem, &efi_mem, link) {
>   		*memory_map =3D lmem->desc;
>   		memory_map--;
>   	}

