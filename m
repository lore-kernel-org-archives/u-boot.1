Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4630606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rqxrbI4E;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SEmoEr1y
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0C0B4073C;
	Wed,  4 Nov 2026 12:51:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qG2pAXQFRDOs; Wed,  4 Nov 2026 12:51:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0B2B040748
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793796712;
	b=lqA29uKvAg8ARnGJxdr8xH6e1o3qRUNZQ6R4Eu2Pl3u5dF9fX8eIF394bqWjKGW4sRE3
	 cYQbduhMf0I9Ux7iw0ISxk0I1Z2VjD3nUBKyDdlOqJXsuT0d1q9E8Ph1xLJiiXSa6agNq
	 IB5EdFOuD++7pCK14ASvSHNGeL2eL20MoR9ypmafV9Ef4po68JZYhucd6sarcCl5tnRzO
	 gXEVGYJryEf27WcL8xU9V/jKnaSAAMsKHFkrTTHET2qDo4VZ42FfgGrP4HREiJXj7M3T4
	 uX8TwMWSrkDs1LxzsEmj2/dH/Bah1SebVXg2YMxuF1mSYvjxvbz12Nxtg3ZphtClr8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793796712;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=N1Qf24tsvGhkjziKFjcilsCbyJCI8Ba13jR07eo4kG8=;
	b=gECmJsRaX/AtDzHNHftZ+9UQrBM2mmpku2avpMi5DXqjgNpTeGtIFCme4ed/P/Trndk9
	 BYAm7l+iov+fIFzhPmnvVD3pqyrNQEDth3aMFUzi1Q1+kaM/+qLnF4iCA+ADjNZwAPW5S
	 /l9IbY5pZIE16e535SUVVa5DpEnfmIi9b+GPQcpw2Sb6C5ZkOnCCqS9QEcgN3Fd19+HL1
	 DZ17A8k0DEq96W4F3yKCXP9r2k7J/oIxTXaIL/QFMPVNSv6Qdbg3H3hTPdtcTMNu8Mj0w
	 0VaoAmtGT361g2P+g5rXYCRo69yTHav2ci8tcVM4zx6pcPcYapfZDptgAhLSy5LqdGw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SEmoEr1y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793796712;
	bh=N1Qf24tsvGhkjziKFjcilsCbyJCI8Ba13jR07eo4kG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rqxrbI4ER6KH525ag6R1v98vEiWQSKFc36eCD7+tXTrTbpWSp5PcS3hg67UqdkMkK
	 FKaTMpl+KQTn/fzANwMH7fixSora/U7T7GJy22yhUqkvC7i5EDEv6bNXBjx1b9f+ds
	 N2V4RPDuC8eBU4t7eN05lTB7a4GxvhYXOJknaQcW2l9Bo28EmSZ9J9OTxf3jKSazDt
	 oIxc8aiwffMiQVhzvC31fc4vdGyjtkRChjDsJynaMEe/yd50AGEYu9+Fc2m6VgdDHG
	 e8VFvsgnEJPOZpuzvuQwzl23MouZkgyiGKtW2uZjBh0UwxyuLnH7RIbr7CHIDvXU1T
	 f1E99iUiL873A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B2B040748;
	Wed,  4 Nov 2026 12:51:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C3756435
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B489440748
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B2qm7lW3lLKx for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 12:51:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B3CF74073C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793796710;
 b=DYdDABEJpTudkbQNd70taxctS3kEdXjnN60mzZVD5XfVFZerYOYqEi/+SZ/uFF+w7I4P
 q26JxIFSqeoNxhAC362/vBFjS3Ctrcapreg/aALFm3bJfZyPPaZlEVKNkwr5KExHG75L/
 JClqyU62NeMUL7tke6JgCDfSA6no0ZAY5ikLhRgRKQV/N1525hGWuHr9xN1zYy3KMzqwJ
 045xA2aEOfN93xQxJakMItNZBjVadpgLuta2V+Ty76OjS5vaYzMd5F+LCDu1TZjbGPRl/
 HCmNd2YUE6W5Zg2L0AL3buHboeOeMPEnLd4lXt2TFIDuuqxsRjDycyn0JFbFRVsrWrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793796710;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=N1Qf24tsvGhkjziKFjcilsCbyJCI8Ba13jR07eo4kG8=;
 b=LwSv8bUCvMo0+dMfMw2t7pYXNF6rVNTLHNU++XweA37Fv9aDH/39LTHWLTkCrMna75ln
 AxO0UyAA9bz4Zmd9B+Qe4LR4o+RLf8vfXEv9zrS6PBOqUUzMHemweL8ucAhtb/6ITxX13
 ezkpPzJSGY5lhDP+JbWV0bvvXAFj738zMvu4APtUdbwgT0cAp8O8REQvlWyEE6UjZLNOO
 UpaDJoSx1OZHwb/V/DDYUlQx04u0ZVwzyeD/UcBi2PsdAFKec1IQHtY2yeE0Lsaju2Y+d
 hbtSxzSuDXOqaddHn7zHMx4E0oLMjNzjdOUHtwS7IYyOzgvGVhYhWs9ctLFAQ9Dj3Fw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=SEmoEr1y; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=SEmoEr1y
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B3CF74073C
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 12:51:49 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6afbc363efeso878485a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 04:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793796707; x=1794401507;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=N1Qf24tsvGhkjziKFjcilsCbyJCI8Ba13jR07eo4kG8=;
 b=SEmoEr1yQhqt/35nbAY+5R7/GVKDZk7KzodZFsA4bT0jYwxiVmnNTnFxL9QMLGAPwm
 UuTzQhp66B5ysTn7M0tuCZfTkFC4irJMkge3a3Rn2xI1yH2JZrdwNlo41rtW0bpaCaqx
 9r4Vc5j97Av8XEpTCw26Em1SSlB0vSD8Jj/I7fLZiONFZ1DyIZwbOfxvFSJJHSQTVWtc
 HTL2mA4UEQd6PWgV5JdEDQ6TYfYNzSu2s5FSWjSXirAI07d36oagcyFF4Yk+lX4Jya7+
 RMHe0TFw95j+OBRagmtJfKRuHn6pQFKqn19BBUxMU2PyN1fFObyBIgItLbjlg7m2FT2X
 4Lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796707; x=1794401507;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N1Qf24tsvGhkjziKFjcilsCbyJCI8Ba13jR07eo4kG8=;
 b=toUwIWnyyROugBIHPAt8oe3Vin1fAoAqp+Ft6FFJJRsQYGqgNsggTFGDcWcehuXmtM
 r7jzasPBMPa8CxgZuzQLoSW/n7pe0Nj8WSn481HceTAWRSPG0veoWFVDq8qZuYvxRAtU
 kAXPdLUexcMEdYUfVD42z7eV1Ims3LmIp3Xqj2QymWB+URAN4A1QYcAvps/22svqosq4
 L6YFFoQGB1IHzj4LwMN98AKpduzdKoy+vi7yoGZT5FCTIkFlzcOK3o0e/I3T1abgG6Qh
 QSgKqWHFK8R+UwXYt6pR0xKRN5J3gz53bxQcLLPh08U4/0IZqVzKMl36mpMDjAP5s1Mm
 ztWg==
X-Gm-Message-State: APuU4Z9WPXFcC3OZBzzLDG0ob5zjFU9uZdOzhS80fgaqMFIQHVs9Q5DE
 lTDUEKxV68hhWj9PmnOYgBvDSDPPoxOxrQBa7W9VKPWiKzvPN8xH1JZJxfEG7S9byX0=
X-Gm-Gg: AYBFou33xBd1pv7Wx6yKhlfFhmMLuSiQWRhIb0GJPV2D4wdsQ5Dd/A1wWfUObLTvuVz
 BzZz9bztXWJPulJZZhxpLxCwALmqZImf6shxRB2iRtT3tgmCpSNdXuAGS/Cwdu7ZHXli4lsr0Z6
 O5GT2dmwBVv0lp48DzMN6CwRqHBNX9M58sSVqLjkfiZAk2ZVyH/Fd5qACJUNxgy3grByTIxX/vt
 Z0C3r3YWBmOwRwUabaw9MiZ+jW9ysMVKJHvfA3nWlA2Im9/ehHIuw4qV36WBQMIK6ZwbQqiJK48
 ZGZSV9HSbu1hdw4+NPA57aU9T8R60NzXsbZF+KiKaXKOaUJt8r1jZknXRq8Cd30shfiFGO991It
 qc+Pegk8Y21rEbd+3s3HA6UoTb1yXLC2EPGZq+rdPmhzoaJuZIUZo/18yNW07zZFjNV3FgrW9NN
 HWb1i/3z8rOidGR4bi08Q4ohqhuMIvdwBstl7NGtX2AHOm16hLfIS+ep2302iXew7kAbKlbpGCw
 CYOLQsBw6DkuBCOJZZPJpkqxtx5nR8lBKSdyYmI3VLlknRsE0EuHCklOK7PJwXGg2Lj3CL/V9sK
 9UrbZ8MTCPjdpAdYajDg4k5UrehQelY=
X-Received: by 2002:aa7:c1cc:0:b0:6b3:f840:59b5 with SMTP id
 4fb4d7f45d1cf-6b4d4c71d29mr8758396a12.27.1793796706986; 
 Wed, 04 Nov 2026 04:51:46 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b561955d0csm438090a12.8.2026.11.04.04.51.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 04:51:46 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v4 13/14] efi_loader: Index the GPT entries directly in
 tcg2_measure_gpt_data()
Date: Wed, 04 Nov 2026 12:51:45 +0000
Message-ID: <9dba21af-23eb-436e-8421-43e5d834772f@gmail.com>
In-Reply-To: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
References: <1369653d-e0d4-4baf-adef-895a24190250@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

tcg2_measure_gpt_data() now measures the GPT that part_get_gpt() gives,
whose entries are always sizeof(gpt_entry) bytes, as
validate_gpt_header() refuses any other size. So index them as an array
rather than stepping by sizeof_partition_entry, and read
num_partition_entries with le32_to_cpu(), as the rest of the GPT code
does.

No functional change on a little-endian machine.

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v3)

Changes in v3:
- New patch (Simon)

 lib/efi_loader/efi_tcg2.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 97fce462138..4045af9afa3 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -1168,8 +1168,8 @@ tcg2_measure_gpt_data(struct udevice *dev,
 	efi_guid_t null_guid = NULL_GUID;
 	gpt_header *gpt_h;
 	gpt_entry *entry = NULL;
-	gpt_entry *gpt_e;
 	u32 num_of_valid_entry = 0;
+	u32 num_entries;
 	u32 event_size;
 	u32 i;
 
@@ -1235,17 +1235,15 @@ tcg2_measure_gpt_data(struct udevice *dev,
 	}
 
 	/* count valid GPT entry */
-	gpt_e = entry;
-	for (i = 0; i < gpt_h->num_partition_entries; i++) {
-		if (guidcmp(&null_guid, &gpt_e->partition_type_guid))
+	num_entries = le32_to_cpu(gpt_h->num_partition_entries);
+	for (i = 0; i < num_entries; i++) {
+		if (guidcmp(&null_guid, &entry[i].partition_type_guid))
 			num_of_valid_entry++;
-
-		gpt_e = (gpt_entry *)((u8 *)gpt_e + gpt_h->sizeof_partition_entry);
 	}
 
 	/* prepare event data for measurement */
 	event_size = sizeof(struct efi_gpt_data) +
-		(num_of_valid_entry * gpt_h->sizeof_partition_entry);
+		(num_of_valid_entry * sizeof(gpt_entry));
 	event = calloc(1, event_size);
 	if (!event) {
 		ret = EFI_OUT_OF_RESOURCES;
@@ -1255,17 +1253,13 @@ tcg2_measure_gpt_data(struct udevice *dev,
 	put_unaligned_le64(num_of_valid_entry, &event->number_of_partitions);
 
 	/* copy valid GPT entry */
-	gpt_e = entry;
 	num_of_valid_entry = 0;
-	for (i = 0; i < gpt_h->num_partition_entries; i++) {
-		if (guidcmp(&null_guid, &gpt_e->partition_type_guid)) {
-			memcpy((u8 *)event->partitions +
-			       (num_of_valid_entry * gpt_h->sizeof_partition_entry),
-			       gpt_e, gpt_h->sizeof_partition_entry);
+	for (i = 0; i < num_entries; i++) {
+		if (guidcmp(&null_guid, &entry[i].partition_type_guid)) {
+			memcpy(&event->partitions[num_of_valid_entry],
+			       &entry[i], sizeof(gpt_entry));
 			num_of_valid_entry++;
 		}
-
-		gpt_e = (gpt_entry *)((u8 *)gpt_e + gpt_h->sizeof_partition_entry);
 	}
 
 	ret = measure_event(dev, 5, EV_EFI_GPT_EVENT, event_size, (u8 *)event);
