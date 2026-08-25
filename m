Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25938C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 20:37:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83E7280CCE;
	Tue, 25 Aug 2026 20:37:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cw4s7Elj0sGa; Tue, 25 Aug 2026 20:37:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787690221;
	bh=Sq82lmDnaw+MtpVgu1/8NclJomd5s8f9f6m/P7g+g+o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QtY64k//TEsiKxjogxfj8GW0gQQ+eNKi5KiQqDkuKd4G8j6xHRgbcAVP4wlPy4poH
	 7s3q5RdVgLJ6tuDDsp2Zas8ImSScSJ52quY+ptIfc80EXSMTIO5O0WEXXtzvnnVVpi
	 k4SZp8Q2I6pBYq2TPCkEO8TKZeGjpCCCEoTpGKZwXAKYtfzx7Jz0CxdJoX7r1qdq6q
	 uMofpscMAh+GaU3hHKU34Nlgm4QuXPSXZD4nO7khTh55biiXpF6+weqxaYhoLqus/F
	 OsncPI1Vrl4PQ1zby9Hofn8GnVrwHj+QxuOEC/c37Vq1vL7vI3A6Q/OshtBhVeFp6v
	 Nw507SwpOv5Ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C41780C9F;
	Tue, 25 Aug 2026 20:37:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C3F4839E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 20:37:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5723400A4
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 20:37:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bufD0kUDidMi for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 20:36:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=aJvCXDXu
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E98E840055
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 20:36:57 +0000 (UTC)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6283D3FC11
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 20:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787690215;
 bh=Sq82lmDnaw+MtpVgu1/8NclJomd5s8f9f6m/P7g+g+o=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=aJvCXDXuzd5jWm4eWZQ+t6oH6MPuH++DMZji1hbi2i+7UT2T97mWaXSL1TtroAJkF
 jmHGX7ueFdV81AE1UYBr7bJNogHPOrnORuUEtBSt+1BOHFTnq/gUIlU+LdQ0kddW+P
 cpZuhaB4LQkCmS/w5GmCBLjQ5aZJmN5aNCAAdfEi+iCrc3h/BhCUwMrOypYQW+56Io
 EjwaCDGGU5QV7/UL8uXBsRZkoy68M//H3euYEU4Cof6btQQ9K3zGWesiDqj2RE9Oo9
 6xRNKsiKpBSivHQ35YbUXe4XE8HMtBq8QjQ3SKpVbBJ5GhxqZnVGk3KEOJ5bsL8oir
 rcoMeHV6ytYzkM2DU9EJuP8pVkludDNHH4TtuIxufIXr0TCUAlH7ntHhKudRmTRwXk
 e+simwc8rI6vTVdQyUgL9iAgu9gQ4TmsvviZowENzI/3tsWy9FdySf43cEFIorCwsZ
 zUii64CeVziwJozhr/yrGQjzijdFSu6wv0btnXFZgSJMu9q1rXX9m0f/mkZpIvLvzn
 KxgK7q5c1PV/ctVkmsTQoZ0fQ1FXtjJkqVra8oFC//uUkIajiOMlT2GMjRQOvq8ZfX
 k6Up/+lHHUF+Fuq1IiA6XKL2LFOEMYEOvzx8C8uZNj6icr0YgDKTxfVT/r1YXDrneZ
 zgtpRNURkleg0Js1qdwuyEtk=
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6a19d668ba3so268652a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787690215; x=1788295015;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sq82lmDnaw+MtpVgu1/8NclJomd5s8f9f6m/P7g+g+o=;
 b=emiKMCGXkuBweKVf2K8oTLsB+skiJsiPbZBrztrKxKq2KD9lpaG87eO915VC4RwBIW
 VGuf3iY7eiz1o+NCJ7E9p70aoGpDVVQ9tmqgQRUps4qsZBy2im1SueBNXO1fqr34B2n9
 AbMT60P4ujM8TEtkynBNzIpI0PQZGXmGxAyltytu7aIL2I75yoBfBZlPDZ95NF1nmK1+
 wMZcGQ+IBS9XhHbAZlrKgWXoWHgE5//PMBRKSdN0bB3t6KGyy9kPsCPxlP0iZqa30elQ
 MHD5YCJSBvUe//Bq3Q1Zyo7Dpf9+9xtCDVPnqnwiXDTc8/eggBNyQ2pweLi7exjPKavj
 JVUA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+LbSBdEu5swP0DvOfDJDumEkZ65JY0uq2cKsrCxcMl+Wn6f17NBdxWuYGuNEnQQj/hw3bfm4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mF2OgugKDJGb+8VcbhOGXolnsFVMprzu0i7KvOCes5E+P0OGzH
 skpu/xQosZ4n1lM9htWEb0LVwWq2y16MHQse23DI8EutgpWHiflu8Tl8+KZk99Fb/FLgUp5KfoN
 F5YvX+1DurLEdLKQ9m9IwvZSuerds8MQUcq58K5a6l3I/INnliamWykXeR7IUT0VS7rtSBfUg/O
 AkKuT9bhjJmQ==
X-Gm-Gg: AR+sD11OQ/safBBKa7AxPgUS1WnoHqzqSGsPsFI7Y9ZkMTc216d4KBRqBdR3qyRfgUX
 GjpQAOmnVnX37Vv2bGzGqTeT1fy48KfKNvE7JwlUSXxkXIh2H8hBv85oMlIUt8FjKpztTVyEeC/
 sshsWFDYSLdoHmzemzu4LKoSBq20wd1E/xHnbE8RvPkS/Bgm1vwXmgQnUD3k/xfW7k94nTJnuS8
 yIpMiB6xxNiwpvWew2/4qRcwEUxLPCfPdVz2xx29J2ksVc1vNjfiiJJ+wVC5zrLOJjVQSZt32CT
 6AroVY5giskcX89FXr7z6om4Fv+V3/2mlkHdijpCWNqBhubLS+l76LOFJ1eH7Ve+b+T1wC9tVPj
 YEoqMCL3JxT12tB13ue4/6s4RnAjMnIcOqjTrF67WkikeWc8/oLZCgc0FCAw5ybSC025GsUfv4/
 ysZsXowhrDNkRdqsVOaKx1
X-Received: by 2002:a05:6402:5043:b0:6a0:dda3:83db with SMTP id
 4fb4d7f45d1cf-6a5df31b0f7mr1967765a12.0.1787690214985; 
 Tue, 25 Aug 2026 13:36:54 -0700 (PDT)
X-Received: by 2002:a05:6402:5043:b0:6a0:dda3:83db with SMTP id
 4fb4d7f45d1cf-6a5df31b0f7mr1967722a12.0.1787690214588; 
 Tue, 25 Aug 2026 13:36:54 -0700 (PDT)
Received: from ?IPV6:2a02:3035:667:9a84:7c86:797a:e54:8957?
 ([2a02:3035:667:9a84:7c86:797a:e54:8957])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8b641fsm1228744a12.3.2026.08.25.13.36.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 13:36:53 -0700 (PDT)
Message-ID: <33c631d3-70c4-4cfc-a351-c43e5553dba3@canonical.com>
Date: Tue, 25 Aug 2026 22:36:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] test: dm: part: Check the GPT layout for large sector
 sizes
To: Alexey Charkov <alchark@flipper.net>
Cc: Tom Rini <trini@konsulko.com>, Anton Burticica <mouse@ya.ru>,
 Javier Martinez Canillas <javierm@redhat.com>, Simon Glass
 <sjg@chromium.org>, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>,
 u-boot@lists.u-boot-project.org,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-4-a3f1f16b53ae@flipper.net>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260731-gpt-4k-v1-4-a3f1f16b53ae@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 7/31/26 14:40, Alexey Charkov wrote:
> Add a test that runs gpt_fill_header() and gpt_fill_pte() over a range of
> block sizes and checks that the partition entry array is sized and placed
> consistently, in particular that the backup array ends exactly where the
> backup GPT header begins.
> 
> Neither function performs any block I/O, so the test builds a synthetic
> struct blk_desc rather than needing a block device with a configurable
> block size. The expected array size is taken from the GPT header fields
> rather than from GPT_ENTRY_NUMBERS, so the test still holds for builds
> with a non-default CONFIG_EFI_PARTITION_ENTRIES_NUMBERS, such as
> ARCH_SUNXI with 56 entries.
> 
> Without the preceding fixes this fails on the first block size other than
> 512:
> 
>    test/dm/part.c:313, dm_test_part_gpt_blksz():
>        entry_lba + pte_blks == first_lba: Expected 0x12 (18), got 0x22 (34)
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Thank you for providing the new test.

test/dm/part.c is never tested in the CI on big-endian systems as it is 
restricted to the sandbox.

The sandbox restriction arises because test/dm/part.c relies on MMC 
drives emulated on the sandbox. We should instead create memory backed 
BLKMAP devices. Then we can run the partition table tests on QEMU and on 
real hardware.

For your new test I would suggest to simply move it to a new file in 
test/lib/ as it does not rely on the presence of block devices.

Heinrich

> ---
>   test/dm/part.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 100 insertions(+)
> 
> diff --git a/test/dm/part.c b/test/dm/part.c
> index ad37d7f406f4..4b48322fb807 100644
> --- a/test/dm/part.c
> +++ b/test/dm/part.c
> @@ -5,6 +5,8 @@
>   
>   #include <dm.h>
>   #include <env.h>
> +#include <malloc.h>
> +#include <memalign.h>
>   #include <mmc.h>
>   #include <part.h>
>   #include <part_efi.h>
> @@ -248,3 +250,101 @@ static int dm_test_part_get_info_by_uuid(struct unit_test_state *uts)
>   	return 0;
>   }
>   DM_TEST(dm_test_part_get_info_by_uuid, UTF_SCAN_PDATA | UTF_SCAN_FDT);
> +
> +/*
> + * Check that the GPT layout adapts to the block size of the device. Neither
> + * gpt_fill_header() nor gpt_fill_pte() does any block I/O, so a synthetic
> + * descriptor is enough here; partition_entries_offset() reads the device tree
> + * '/config' node, which is available without scanning for devices.
> + */
> +static int dm_test_part_gpt_blksz(struct unit_test_state *uts)
> +{
> +	static const struct {
> +		unsigned long blksz;
> +		lbaint_t lba;
> +	} cases[] = {
> +		{   512, 0x2000 },	/* 4MB, the traditional 34-block layout */
> +		{  1024, 0x1000 },
> +		{  2048,  0x800 },
> +		{  4096,  0x400 },	/* 4K native media, e.g. UFS */
> +		{  8192,  0x200 },
> +		{ 16384,  0x100 },	/* the array fits in a single block... */
> +		{ 32768,   0x40 },	/* ...on a device smaller than 34 blocks */
> +	};
> +
> +	char str_disk_guid[UUID_STR_LEN + 1] =
> +		"8d60b397-1bb6-4d33-80ee-b1587d24c2f8";
> +	struct disk_partition part;
> +	struct blk_desc desc;
> +	gpt_header gpt_h;
> +	gpt_entry *gpt_e;
> +	int i;
> +
> +	gpt_e = calloc(GPT_ENTRY_NUMBERS, sizeof(gpt_entry));
> +	ut_assertnonnull(gpt_e);
> +
> +	for (i = 0; i < ARRAY_SIZE(cases); i++) {
> +		u64 entry_lba, first_lba, last_lba;
> +		u32 pte_blks;
> +
> +		memset(&desc, '\0', sizeof(desc));
> +		memset(&gpt_h, '\0', sizeof(gpt_h));
> +		desc.blksz = cases[i].blksz;
> +		desc.log2blksz = LOG2(desc.blksz);
> +		desc.lba = cases[i].lba;
> +
> +		ut_assertok(gpt_fill_header(&desc, &gpt_h, str_disk_guid, 1));
> +
> +		/*
> +		 * Size the array with BLOCK_CNT() rather than the
> +		 * DIV_ROUND_UP() that gpt_pte_blocks() uses, so that this
> +		 * checks the layout instead of restating the implementation.
> +		 */
> +		pte_blks = BLOCK_CNT(le32_to_cpu(gpt_h.num_partition_entries) *
> +				     le32_to_cpu(gpt_h.sizeof_partition_entry),
> +				     (&desc));
> +		entry_lba = le64_to_cpu(gpt_h.partition_entry_lba);
> +		first_lba = le64_to_cpu(gpt_h.first_usable_lba);
> +		last_lba = le64_to_cpu(gpt_h.last_usable_lba);
> +
> +		ut_asserteq_64(1, le64_to_cpu(gpt_h.my_lba));
> +		ut_asserteq_64(desc.lba - 1, le64_to_cpu(gpt_h.alternate_lba));
> +
> +		/* the primary array ends where the usable area begins */
> +		ut_assert(entry_lba >= 2);
> +		ut_asserteq_64(entry_lba + pte_blks, first_lba);
> +		ut_assert(first_lba < last_lba);
> +
> +		/*
> +		 * write_gpt_table() puts the backup array at
> +		 * last_usable_lba + 1, so it has to end exactly where the
> +		 * backup header begins
> +		 */
> +		ut_asserteq_64(le64_to_cpu(gpt_h.alternate_lba),
> +			       last_lba + 1 + pte_blks);
> +
> +		/* a partition with no start and no size fills the disk */
> +		memset(&part, '\0', sizeof(part));
> +		disk_partition_set_uuid(&part, str_disk_guid);
> +		ut_assertok(gpt_fill_pte(&desc, &gpt_h, gpt_e, &part, 1));
> +		ut_asserteq_64(first_lba, le64_to_cpu(gpt_e[0].starting_lba));
> +		ut_asserteq_64(last_lba, le64_to_cpu(gpt_e[0].ending_lba));
> +
> +		/* a partition overlapping the entry array is rejected */
> +		part.start = entry_lba;
> +		part.size = 1;
> +		ut_asserteq(-ENOSPC,
> +			    gpt_fill_pte(&desc, &gpt_h, gpt_e, &part, 1));
> +
> +		/* so is one running past the end of the usable area */
> +		part.start = first_lba;
> +		part.size = last_lba - first_lba + 2;
> +		ut_asserteq(-E2BIG,
> +			    gpt_fill_pte(&desc, &gpt_h, gpt_e, &part, 1));
> +	}
> +
> +	free(gpt_e);
> +
> +	return 0;
> +}
> +DM_TEST(dm_test_part_gpt_blksz, 0);
> 

