Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A21606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DqicWAuq;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YPC3HvhE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CFC060AA4;
	Fri, 30 Oct 2026 06:13:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eRBFc6JqR_cQ; Fri, 30 Oct 2026 06:13:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5092760A70
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793340838;
	b=NGOvZ/bzSpDBccxQwTpt86ACosUdXFRhz9/JBUWID+IgaDmLjcOXqIG4vDKB70fNEf+w
	 Pb+sWoeltrkNfsyuefGN7hw+bl8METNRcpDJvXtbknd10ujKQfv7ljtLLWqJ+vjq8fzZT
	 BKwo/jMVbADniFgsoQb9SQwrLqBYgINs++WH/y91SO3oScW9MV3xouldRVTcD2U8cdXR2
	 iXQRj2Zf16+PAdmu6LUGymDPvBwwWIZ1VpKM+7eUDmVNMfHzqii3tpGGJDKJRmxB4Pyer
	 XdXhPA5aFjN6BF2f9Mlr8iQhyS/J9z4xO5979vf1dad2bAwoMKov2joY0FNtHvxh9sQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793340838;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=gTY8bNTbPDejt8C1rN15t3fSDthbvanWxJv7+kLNmtY=;
	b=rjkp8Of6iCyBecYpP1W/8SPMpFgFREuLPNbuLjxtDEW9qa7pF1KinTjyNTuE0nZYcjVX
	 56VydEOJ2EgYbY82Hypz1DpO3R+QnDWpYNOq0XdclWVNZQiUob25QUIXnKMqKCZaYLU4M
	 XneDglFVQzXIT+PtWAKHyV2JWIqvBENXh0WTkZtqsR6d17c1gaz6IveUQDAJv+Yxntk1R
	 3CFtGqrWhZsEaHa2Q/pLR1FRjRWfaRvdCkvtrDbaK27W3MwTpg85Px8XUfza4H04Cnsbu
	 U3d2WR0gCiI81g5G7+GeOBE7nDP7VMXqro5XpxFJ/CeWkYmozwwUQFs6o+3lLBycTtA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793340838;
	bh=gTY8bNTbPDejt8C1rN15t3fSDthbvanWxJv7+kLNmtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DqicWAuqsAiypYUPY3l4J7P0MdINLUcgF7IdE/UT24qal/uUWmiuqHvV54GffdKAo
	 CaP3vMlMwzvpzMYpxWpQZVKz3CQAc1ZhX4+iNcqSlek0b+Yw8jnocxEFCpMn+h/Ij9
	 Gh4ufyCaehCVVxBzumS5oDvHz+z6HjKO5dzqUW3cc9w6IDi++b6bLlo64k9I5BZs1P
	 Yq3Rb9qMXEj50vVs0TNC4yaQKXXUjDwUeK/Yq1moNIqtVdyW8LeI1Q0VsAxhi6TQnc
	 EUfQybIaL3/bVFswNM7Bt2TuCqYarKcIuokKdOTOUQNfZ6b333kEyHm1NBGLDXmeke
	 xohECCJ8r5RRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5092760A70;
	Fri, 30 Oct 2026 06:13:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DBAC1712
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:13:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C0F6380DE8
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:13:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pv9Y0xW3RBaI for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 06:13:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5536A80D3E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793340835;
 b=B7FH+m/Pn5+2TjW3BEE1nMQ5Fc1UmsvrmsU/z/U+Zg4uXrM8M5EYB+XNrFTHVFWTIU46
 g+MCkdvD90Bo5aReuFiQLSZYVeJ9jLkwnq5OzIa+htznBgcDrko6A2lH10trojhhvERIO
 RSzyxYTQDNcB/0JyinxWzJWVwoOMAUcuEOVp3HyFcG2H8UvtsFQ/wLtjXt9zb9iee/GMf
 xt4565RZ+PjCuQucfY2sNMCLOMlW6kc0BsEMTUZEZC/iPAlNN1/Dkm+uOd6ZSmT8Lb6oB
 75gAf+kD8REqPCazNzAm2Ce5uNUsZhZJHxEcdKf1k6w+J6i/ZETMxOBIbzIZTVAxjhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793340835;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=gTY8bNTbPDejt8C1rN15t3fSDthbvanWxJv7+kLNmtY=;
 b=qAO8jqh+usGFTk3CnOSPL/dBqy8HXHyD7VJUcqi+IHP02ZormPXfEcahVKQVqjwrRNvR
 DYoHjEpiPsBCPIG14hpbUPnRaTx61J5TRxHL8hGKoOW17MqeQs5OJG34u93aJrFHwugn2
 upnanj1HsKI6APLwyf3jYM79GVX4RBslmQeTxGY4jEL/20vL3dqyJs+aN3PKm145mH3JW
 JlPa3X4LYMCN2/D3bA8y7WgAPzTkCWhrtW/kTqIeYuM1D3ECcBdR4NgSTLSF8q6cJjNff
 EiVcALDwBOHwfuVYAjc3i9dJ7PdSWHb5Kfstyrdma89OQxWYh2VzOsUfiCbWd45Mtdw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=YPC3HvhE; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=YPC3HvhE
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5536A80D3E
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:13:54 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso134636f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 23:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793340833; x=1793945633;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gTY8bNTbPDejt8C1rN15t3fSDthbvanWxJv7+kLNmtY=;
 b=YPC3HvhEtiODg3W3oFGYrSjVmfvAY4VmwP6D665gl1uTfn084nhi6256f5l7WAHux3
 3ml+iQMAMTEep9LEcp/rdUyEvQO2gR3wNjZlg1wX0Khvje2EQ2KyByZcYi+vGeWgugtK
 2NLFcm1/MnqX1qJVfZ8EsosGMb8T+Hm32SrwIaEoAXZGrVILY/NgqJRJwvm8GPH4xkU1
 GeVEr/cuwnkqjyDYLpxTCl0PNLNRSjADaZjtb6tzRZnLrQRkmPNvYxHsX755U/tErgyj
 UceqD7UkSUnczENae/3L4Ra6BYGRdzcY2U+t5uqFmnlsLT4T6sNJRLQp1gA9y9QISsOs
 b0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793340833; x=1793945633;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gTY8bNTbPDejt8C1rN15t3fSDthbvanWxJv7+kLNmtY=;
 b=Y9DpizUH6EhRPotopAhShFv+qeOxrWquqLuM/7MRq2UNbT0NlTIRliN91pSiS74tJW
 +nJL6yuC31FS+j5RDxgwkb9nY5uS2ib038Vpkn5EyxYCh0EaPzyPlyoGJZBdeXr26qVy
 ALPv7qyEqk/YP0f39G/mA282rS+YOcxpnSzLNUHwoRaMqp94pa3j0ei1BdgsW/OtyDqA
 VgVDk2+30t/2O90Zph0SNjLK+5Fsxy761NcH7FbreloqBE4w8Fv4n0blNlnRlOqL7b+n
 0jfh6BMbq0S8Pd5Sim2wi6aOMID3B+2riwK0oL6hIYY5kXkqsXgj63c6Bn/Bl2lq8sei
 uTlQ==
X-Gm-Message-State: AFq9FYKz6Ca3WE6Wgz8nB0V5ELszijcY0Qtlo0/7CLVd1z+7JQ5n9GT1
 QDzu7E8FmyaB41gV8XibH7z43pyGYlaNzn03zwb2QrQoH3NnpcvyQGixu8m5aK9a3wc=
X-Gm-Gg: AYBFou2n8Yf5ywch4FiqcwIWqqkfJuEpn2jiie2eEiIbDj+QW38psiqJnnRyRQJYUUF
 pSYrxSumqsquNQnFNxRa+rfwfVtgWFcUEgMsdHXKruCKe+EfWUuG82iCFRndTZ1zFMx37ojhvyp
 oXkqyQU7CuysKMC4PDzWOrSr2ovTHaMCw34OlSQ1lxJhQaayCxsIhGRILAHxKf2SiNYkvJgAwCY
 g6PNgwYyjNWJ+DTsx8mQ3ekb6HFGU9LiqVHHjaIdLPRp0/3IFv5pZenD2a2RMqxJ0OTPknmLAuG
 nkMalzMS7IDnH7qdRehYT6ziEJ1ACmyKB4ZQAaDa9WvNUqD+mEIQlj3mYXN6dGq/UutJvU4zPz7
 apRj222vNOTsQ3rPR95cYPzbFd5w57gFBv0vNXN/LSGQEcctZQdWHIiwhxy/FpCk/f7KpnHUVGH
 gnL4/MbLsRpCgm93fJ0ZAmAm2CfGZJ4EIlD4+nOuZcA23HQ5ZeOq+N3XQ3WCoEaz5rF5DnSvqQ1
 6kHYJJOSllf45w00lvAfJ97B2bceGwFe1BLZEWTP/n4sOoQ6QDgWPMySI83sBV+9YpMbwDwijD0
 xMHyPzO1F7EfbVctqHd1PiJ1G8D38RU=
X-Received: by 2002:a05:6000:46c8:b0:48e:4c82:a286 with SMTP id
 ffacd0b85a97d-48e6e2fa53dmr1922633f8f.10.1793340832599; 
 Thu, 29 Oct 2026 23:13:52 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b77f06sm1386379f8f.21.2026.10.29.23.13.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 23:13:52 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/10] efi_loader: check the PE image ranges in
 efi_image_parse()
Date: Fri, 30 Oct 2026 06:13:51 +0000
Message-ID: <fd7c9742-f369-4877-9a14-665b6b8afc2b@gmail.com>
In-Reply-To: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

efi_image_parse() collects the regions of an image to be hashed for
Secure Boot and for TCG2 measurements. It takes the header size, the
section table, each section's raw data and the certificate table from
the image without checking them against the image size:

- SizeOfHeaders and each section's PointerToRawData and SizeOfRawData
  are added as regions even when they run past the end of the image,
  which is then read out of bounds when the regions are hashed;
- the section table is read wherever SizeOfOptionalHeader and
  NumberOfSections put it;
- the end of the certificate table is computed in 32 bits, so a large
  offset wraps around and passes the check;
- errors of efi_image_region_add() are ignored.

All of this happens before the signature is verified.

Call efi_check_pe() first, check each offset and size against the image
size without wrapping, add regions only through a checked helper and fail
on its errors, and require the file alignment to be a power of two. The
padding of a section to the file alignment is hashed only as far as the
image goes, so an image whose last section is not padded is still
accepted. Check the certificate table against the size of
WIN_CERTIFICATE, not of a pointer to it.

barebox, whose EFI loader is based on this file, added the same checks in
4ec1f7166778 ("efi: validate PE parser input ranges"); this is a port to
U-Boot. Unlike there, an optional header with fewer than 16 data
directories is still accepted if it holds the certificate table entry it
declares: U-Boot's own EFI applications have six.

Fixes: 4540dabdcaca ("efi_loader: image_loader: support image authentication")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 lib/efi_loader/efi_image_loader.c | 268 +++++++++++++++++++++---------
 1 file changed, 190 insertions(+), 78 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index e31493d5135..35cf3cd268f 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -393,6 +393,69 @@ void *efi_prepare_aligned_image(void *efi, u64 *efi_size)
 	}
 }
 
+/**
+ * pe_range_ok() - check that a range lies within the image
+ * @len:	size of the image
+ * @off:	offset of the range from the start of the image
+ * @size:	size of the range
+ *
+ * Return:	true if [@off, @off + @size) lies within [0, @len)
+ */
+static bool pe_range_ok(size_t len, size_t off, size_t size)
+{
+	return off <= len && size <= len - off;
+}
+
+/**
+ * pe_align_size() - round up a section size to the file alignment
+ * @size:	size of the raw data of a section
+ * @align:	file alignment, a power of two
+ * @aligned:	on return @size rounded up to @align
+ *
+ * Return:	true on success, false if @align is not a power of two or
+ *		the rounded size overflows
+ */
+static bool pe_align_size(u32 size, u32 align, size_t *aligned)
+{
+	size_t val = size;
+
+	if (!align || (align & (align - 1)))
+		return false;
+
+	if (__builtin_add_overflow(val, (size_t)align - 1, &val))
+		return false;
+
+	*aligned = val & ~((size_t)align - 1);
+
+	return true;
+}
+
+/**
+ * efi_image_region_add_checked() - add a region of an image
+ * @regs:	pointer to array of regions
+ * @efi:	pointer to the image
+ * @len:	size of the image
+ * @start:	offset of the region in the image
+ * @size:	size of the region
+ * @nocheck:	flag against overlapped regions
+ *
+ * Add the region [@start, @start + @size[ of the image to @regs if it lies
+ * within the image.
+ *
+ * Return:	status code
+ */
+static efi_status_t efi_image_region_add_checked(struct efi_image_regions *regs,
+						 const void *efi, size_t len,
+						 size_t start, size_t size,
+						 int nocheck)
+{
+	if (!pe_range_ok(len, start, size))
+		return EFI_INVALID_PARAMETER;
+
+	return efi_image_region_add(regs, efi + start, efi + start + size,
+				    nocheck);
+}
+
 /**
  * efi_image_parse() - parse a PE image
  * @efi:	Pointer to image
@@ -401,8 +464,8 @@ void *efi_prepare_aligned_image(void *efi, u64 *efi_size)
  * @auth:	Pointer to a pointer to authentication data in PE
  * @auth_len:	Size of @auth
  *
- * Parse image binary in PE32(+) format, assuming that sanity of PE image
- * has been checked by a caller.
+ * Parse image binary in PE32(+) format. Each offset and size taken from the
+ * image is checked against @len before it is used.
  * On success, an address of authentication data in @efi and its size will
  * be returned in @auth and @auth_len, respectively.
  *
@@ -411,97 +474,135 @@ void *efi_prepare_aligned_image(void *efi, u64 *efi_size)
 bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
 		     WIN_CERTIFICATE **auth, size_t *auth_len)
 {
-	struct efi_image_regions *regs;
-	IMAGE_DOS_HEADER *dos;
+	struct efi_image_regions *regs = NULL;
 	IMAGE_NT_HEADERS32 *nt;
-	IMAGE_SECTION_HEADER *sections, **sorted;
+	IMAGE_SECTION_HEADER *sections, **sorted = NULL;
 	int num_regions, num_sections, i;
 	int ctidx = IMAGE_DIRECTORY_ENTRY_SECURITY;
-	u32 align, size, authsz, authoff;
-	size_t bytes_hashed;
+	u32 align, authsz, authoff, header_size, num_dirs;
+	size_t bytes_hashed, opt_off, opt_size, min_opt_size;
+	size_t csum_off, subsys_off, dir_off, dir_end;
+	size_t sections_off, sections_size;
 
-	dos = (void *)efi;
-	nt = (void *)(efi + dos->e_lfanew);
 	authoff = 0;
 	authsz = 0;
 
 	/*
-	 * Count maximum number of regions to be digested.
-	 * We don't have to have an exact number here.
-	 * See efi_image_region_add()'s in parsing below.
+	 * efi_check_pe() checks the DOS and PE signatures and that the image
+	 * is large enough to hold a 64bit NT header, which is longer than a
+	 * 32bit one. Every optional header field and data directory entry
+	 * read below therefore lies within the image.
 	 */
-	num_regions = 3; /* for header */
-	num_regions += nt->FileHeader.NumberOfSections;
-	num_regions++; /* for extra */
-
-	regs = calloc(sizeof(*regs) + sizeof(struct image_region) * num_regions,
-		      1);
-	if (!regs)
-		goto err;
-	regs->max = num_regions;
+	if (efi_check_pe(efi, len, (void **)&nt) != EFI_SUCCESS)
+		return false;
+	opt_off = (u8 *)&nt->OptionalHeader - (u8 *)efi;
+	opt_size = nt->FileHeader.SizeOfOptionalHeader;
 
-	/*
-	 * Collect data regions for hash calculation
-	 * 1. File headers
-	 */
 	if (nt->OptionalHeader.Magic == IMAGE_NT_OPTIONAL_HDR64_MAGIC) {
 		IMAGE_NT_HEADERS64 *nt64 = (void *)nt;
 		IMAGE_OPTIONAL_HEADER64 *opt = &nt64->OptionalHeader;
 
-		/* Skip CheckSum */
-		efi_image_region_add(regs, efi, &opt->CheckSum, 0);
-		if (nt64->OptionalHeader.NumberOfRvaAndSizes <= ctidx) {
-			efi_image_region_add(regs,
-					     &opt->Subsystem,
-					     efi + opt->SizeOfHeaders, 0);
-		} else {
-			/* Skip Certificates Table */
-			efi_image_region_add(regs,
-					     &opt->Subsystem,
-					     &opt->DataDirectory[ctidx], 0);
-			efi_image_region_add(regs,
-					     &opt->DataDirectory[ctidx] + 1,
-					     efi + opt->SizeOfHeaders, 0);
-
+		min_opt_size = offsetof(IMAGE_OPTIONAL_HEADER64, DataDirectory);
+		csum_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER64,
+					      CheckSum);
+		subsys_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER64,
+						Subsystem);
+		dir_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER64,
+					     DataDirectory[ctidx]);
+		header_size = opt->SizeOfHeaders;
+		align = opt->FileAlignment;
+		num_dirs = opt->NumberOfRvaAndSizes;
+		if (num_dirs > ctidx) {
 			authoff = opt->DataDirectory[ctidx].VirtualAddress;
 			authsz = opt->DataDirectory[ctidx].Size;
 		}
-
-		bytes_hashed = opt->SizeOfHeaders;
-		align = opt->FileAlignment;
 	} else if (nt->OptionalHeader.Magic == IMAGE_NT_OPTIONAL_HDR32_MAGIC) {
 		IMAGE_OPTIONAL_HEADER32 *opt = &nt->OptionalHeader;
 
-		/* Skip CheckSum */
-		efi_image_region_add(regs, efi, &opt->CheckSum, 0);
-		if (nt->OptionalHeader.NumberOfRvaAndSizes <= ctidx) {
-			efi_image_region_add(regs,
-					     &opt->Subsystem,
-					     efi + opt->SizeOfHeaders, 0);
-		} else {
-			/* Skip Certificates Table */
-			efi_image_region_add(regs, &opt->Subsystem,
-					     &opt->DataDirectory[ctidx], 0);
-			efi_image_region_add(regs,
-					     &opt->DataDirectory[ctidx] + 1,
-					     efi + opt->SizeOfHeaders, 0);
-
+		min_opt_size = offsetof(IMAGE_OPTIONAL_HEADER32, DataDirectory);
+		csum_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER32,
+					      CheckSum);
+		subsys_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER32,
+						Subsystem);
+		dir_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER32,
+					     DataDirectory[ctidx]);
+		header_size = opt->SizeOfHeaders;
+		align = opt->FileAlignment;
+		num_dirs = opt->NumberOfRvaAndSizes;
+		if (num_dirs > ctidx) {
 			authoff = opt->DataDirectory[ctidx].VirtualAddress;
 			authsz = opt->DataDirectory[ctidx].Size;
 		}
-
-		bytes_hashed = opt->SizeOfHeaders;
-		align = opt->FileAlignment;
 	} else {
 		log_err("%s: Invalid optional header magic %x\n", __func__,
 			nt->OptionalHeader.Magic);
+		return false;
+	}
+	dir_end = dir_off + sizeof(IMAGE_DATA_DIRECTORY);
+
+	/*
+	 * The optional header must hold the fields used here, and the
+	 * certificate table entry when there is one. The section table
+	 * follows the optional header; it and the whole header area
+	 * (SizeOfHeaders) must lie within the image, as must the certificate
+	 * table.
+	 */
+	num_sections = nt->FileHeader.NumberOfSections;
+	sections_off = opt_off + opt_size;
+	sections_size = (size_t)num_sections * sizeof(IMAGE_SECTION_HEADER);
+	if (opt_size < min_opt_size ||
+	    (num_dirs > ctidx && sections_off < dir_end) ||
+	    !pe_range_ok(len, sections_off, sections_size) ||
+	    !pe_range_ok(len, 0, header_size) ||
+	    header_size < sections_off + sections_size) {
+		log_err("%s: Invalid PE headers\n", __func__);
+		return false;
+	}
+	if (authsz && !pe_range_ok(len, authoff, authsz)) {
+		log_err("%s: Size for auth too large: %u\n", __func__, authsz);
+		return false;
+	}
+
+	/*
+	 * Count maximum number of regions to be digested.
+	 * We don't have to have an exact number here.
+	 * See efi_image_region_add()'s in parsing below.
+	 */
+	num_regions = 3; /* for header */
+	num_regions += num_sections;
+	num_regions++; /* for extra */
+
+	regs = calloc(sizeof(*regs) + sizeof(struct image_region) * num_regions,
+		      1);
+	if (!regs)
 		goto err;
+	regs->max = num_regions;
+
+	/*
+	 * Collect data regions for hash calculation
+	 * 1. File headers
+	 */
+	/* Skip CheckSum */
+	if (efi_image_region_add_checked(regs, efi, len, 0, csum_off, 0))
+		goto err;
+	if (num_dirs <= ctidx) {
+		if (efi_image_region_add_checked(regs, efi, len, subsys_off,
+						 header_size - subsys_off, 0))
+			goto err;
+	} else {
+		/* Skip Certificates Table */
+		if (efi_image_region_add_checked(regs, efi, len, subsys_off,
+						 dir_off - subsys_off, 0))
+			goto err;
+		if (efi_image_region_add_checked(regs, efi, len, dir_end,
+						 header_size - dir_end, 0))
+			goto err;
 	}
 
+	bytes_hashed = header_size;
+
 	/* 2. Sections */
-	num_sections = nt->FileHeader.NumberOfSections;
-	sections = (void *)((uint8_t *)&nt->OptionalHeader +
-			    nt->FileHeader.SizeOfOptionalHeader);
+	sections = (void *)((uint8_t *)efi + sections_off);
 	sorted = calloc(sizeof(IMAGE_SECTION_HEADER *), num_sections);
 	if (!sorted) {
 		log_err("%s: Out of memory\n", __func__);
@@ -516,14 +617,26 @@ bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
 	qsort(sorted, num_sections, sizeof(sorted[0]), cmp_pe_section);
 
 	for (i = 0; i < num_sections; i++) {
+		size_t size;
+
 		if (!sorted[i]->SizeOfRawData)
 			continue;
 
-		size = (sorted[i]->SizeOfRawData + align - 1) & ~(align - 1);
-		efi_image_region_add(regs, efi + sorted[i]->PointerToRawData,
-				     efi + sorted[i]->PointerToRawData + size,
-				     0);
-		log_debug("section[%d](%s): raw: 0x%x-0x%x, virt: %x-%x\n",
+		if (!pe_range_ok(len, sorted[i]->PointerToRawData,
+				 sorted[i]->SizeOfRawData) ||
+		    !pe_align_size(sorted[i]->SizeOfRawData, align, &size)) {
+			log_err("%s: Invalid section %d\n", __func__, i);
+			goto err;
+		}
+		/* The padding to the file alignment ends with the image */
+		size = min(size, len - sorted[i]->PointerToRawData);
+		if (efi_image_region_add_checked(regs, efi, len,
+						 sorted[i]->PointerToRawData,
+						 size, 0)) {
+			log_err("%s: Invalid section %d\n", __func__, i);
+			goto err;
+		}
+		log_debug("section[%d](%s): raw: 0x%x-0x%zx, virt: %x-%x\n",
 			  i, sorted[i]->Name,
 			  sorted[i]->PointerToRawData,
 			  sorted[i]->PointerToRawData + size,
@@ -534,25 +647,23 @@ bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
 		bytes_hashed += size;
 	}
 	free(sorted);
+	sorted = NULL;
 
 	/* 3. Extra data excluding Certificates Table */
-	if (bytes_hashed + authsz < len) {
+	if (bytes_hashed < len && authsz < len - bytes_hashed) {
 		log_debug("extra data for hash: %zu\n",
 			  len - (bytes_hashed + authsz));
-		efi_image_region_add(regs, efi + bytes_hashed,
-				     efi + len - authsz, 0);
+		if (efi_image_region_add_checked(regs, efi, len, bytes_hashed,
+						 len - bytes_hashed - authsz,
+						 0))
+			goto err;
 	}
 
 	/* Return Certificates Table */
 	if (authsz) {
-		if (len < authoff + authsz) {
-			log_err("%s: Size for auth too large: %u >= %zu\n",
-				__func__, authsz, len - authoff);
-			goto err;
-		}
-		if (authsz < sizeof(*auth)) {
+		if (authsz < sizeof(**auth)) {
 			log_err("%s: Size for auth too small: %u < %zu\n",
-				__func__, authsz, sizeof(*auth));
+				__func__, authsz, sizeof(**auth));
 			goto err;
 		}
 		*auth = efi + authoff;
@@ -569,6 +680,7 @@ bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
 	return true;
 
 err:
+	free(sorted);
 	free(regs);
 
 	return false;
