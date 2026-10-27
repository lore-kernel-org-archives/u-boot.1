Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C76606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BgqZd4W9;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OdcHo4XO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A249240714;
	Tue, 27 Oct 2026 08:59:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ra5CZsrMG7mA; Tue, 27 Oct 2026 08:59:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B8CD040709
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091580;
	b=PAY6ljOw5HjjyiY7M2QmfBE3/Mfvzm6VDU3jgbt4XL9TqKuMls/LKzVsDp9Rarsu8822
	 TWWSNe5exk3mPDKw4K+B266RmDHeyttHQOl5/D1fZpdD+CcZuLLbLHJrSB6WVXbpt866D
	 CM0ddMeWwfurFcReMdAEFD+4f8trSMA4xFUA3rh9b+DTAizOAAr6PF1XBJkRv9reJ3Cib
	 lVuSnlOuf+x6P28TOyZkHLi8kE6+570lHy4y6UXCF8sb0Uxngo7tFfxrud0NEq6VUeboO
	 2Jus3sBaTPisDe/xaytGtn4UJ6k2QhTcOwDPmoc8oML7ISqwTaJSy5i7jh8XOmj9zdg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793091580;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qp/foBD5Cj5Fy5uaSui4SOawb1JHTtbAOgjfS/g7C1M=;
	b=bGIGdi22xuiBFQwNmTmiC5Vu4v6/L+axs5JDaV5CH6UPHBLgP/JHK2EgACo8gmBrnqe4
	 5ujHjbmCmsgy/P6tBDDsKZnp7Rr4CPguiIH0IJxThvxinVnOBwzEEgez1oDXUZkeARQ1c
	 ipLbMD1S7/H1XveKoBZIJs/bswH8whZCPafwolcGMPfF+lfZiqNrmlmpmTL3pcccKJM+p
	 FqAwzuOfIDTVaalrMrz9cBsmrBpx1lwnb4y8eFPV43vPfLJro81A94GqQgIRQvU1nQbTy
	 aN7ZNEthcxzvscYi18OPX2/1gyPjPjME0MESym+Af6D9RLYxJ7P1ANpwO0J09rZD9cw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OdcHo4XO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793091580;
	bh=qp/foBD5Cj5Fy5uaSui4SOawb1JHTtbAOgjfS/g7C1M=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BgqZd4W9W4K/NAPaIZ/puMSIuRi0uNPaqhGJFiAoxK7DKjxXbh75E8iai3nORL+u/
	 vc4gBG8lsORkeFYowEMpmuqAkURKx3pVNPpAoUEfmXjurygDUfQYmVdacd2Zy5aO7/
	 38ozwnmja8sy9bYvd647QbOk+P4Q2SGIBbiatgUsri+jWfT4sXX9xEFOr9xC6WtJfg
	 m6KhmWsLqfSDRnO35KmVlatgEZ2GZ+masvg+gtz/IE+u1m82Yy7jhfVApQual59DcQ
	 Ka6tMnctpidzx3cVhlpZPm7B/YsYKRGmd1szPqLUatyixP8UxEGnVFnlwtRud3KnK+
	 iIRk8ytQ+lTJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8CD040709;
	Tue, 27 Oct 2026 08:59:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 73628356
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 58B4A4073D
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uXZRCCOE3IPi for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 08:59:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4863140733
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091577;
 b=aRD8HD/+VoRDwh5OX6Glp0hkfGJcsVX88ZVL9wgJdn5oIaFytBwKaOpycDY+5GVKoqu1
 ncqSpvvrQcCO+Bhm/u+Z2ARNxtDLdk3Bxr5sOB3kD2zPwFNsdYigHHqIA/6YQAU7oSAmA
 dbc2aEk0vP6fStfrpfRv3N/DYQyHKKoakNWE1fi8+DRjfImwYSiqgdTvtwEs0hygN4TAl
 7lQWdiuxsAXcUmaztlTWhUOHgZzwMQ0mpbwa3cTidrvZFsf3Evt5SftG//X861YejYcpf
 ZF3TPI5nzXDbRILo/RKnSI4jJt8Ae6f9IOH2lcQ6FymzsMIRrnaEuXrROOSSl/xyT6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793091577;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=qp/foBD5Cj5Fy5uaSui4SOawb1JHTtbAOgjfS/g7C1M=;
 b=LtfGyatpxepN8azzcWcoDUBZYQrUAWtdAhIn9JhQGtIJwQEqawJjcwPO0rPm8ulxFEYV
 av+tkiJFlfek10RjUBaLpuWG0NbsNqXA+LGI5lMIZbD4m+lbqGahpkguRdQm09s9Dad+G
 w48Bf0FhS2+zlWu4JRt+GevEeRlxXjsSdTPvWlcA93G+iphw7WCmpNihFH1HNFAiRpf5v
 X+P6cJw9HplB/HMALD6CCz9FNrUCgAYo2Dl/9/RkT0SUmOhLKluCi91UNBqQ3yOSx8InM
 f3/HySaFMNXbqkpndlV6vOr8JSaFhCKf9JqikGeT084r5akq3I8eoNLDp4sdWZ39hiA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=OdcHo4XO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=OdcHo4XO
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4863140733
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:37 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6ae14eecc64so5253911a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 01:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793091575; cv=none;
 d=google.com; s=arc-20260327;
 b=kwbn3+fg4IWFSSdfIHn63lBO8KA3XdmPEH3w/In7CblMcazMfsqld/ctCO2cCgJ7Wi
 7PzXLaS/p6rOSkSp1HsFS3QGOBB6c8wYslt7K7d+ZlfRCDtoqa2bo9oB/JTtUQ2r5Mwd
 pkZwhAu7F3y0B0KmcH6dsN23/g7C81BvNGkL2t94qClGXTRuFlMUFVDnh+DYGAZ5ZU3n
 Be6RefV+L6DgcrQAqhl6i3lNG4zopQG/NMRTaL6qDRQoFa/MS1eI0SiPJFBQmxoQO/3Y
 qdEVhIhywG0FjC2ZsmVP8TDQvKxlzzqnw1IHB8rzKMT8dRdltnm8cczZSiiI7mRUK6fP
 PnYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=qp/foBD5Cj5Fy5uaSui4SOawb1JHTtbAOgjfS/g7C1M=;
 fh=/rdnnAgt/z8Y/gO/kkwLsOp9dS2eruYSp+dyjwHJTc8=;
 b=cmP6p887vK8lxD9z89TtPRdSI3LSNwOqVSRWMbdlsYhTVqxsd3srvNgDYptCHTrPCK
 eS/O4iS10QjP9dggg4xFTku+QI+3sfpYg2tOJJd5jbotpJvMvmyJ3FNe6h7r6hBvhXXs
 dyTkcfQ0wlSl610SqElid1En2pkXWntshMpgUkuj1KiHXVRK6wGq1qvHQvRwPUWGyT8g
 g8rfM4LbNcLBK39l7LjnV1VkZqifSSk2JKD+GqIGcPby/6Wbr1pZpEjTn3At4QIqXfPW
 8I2lAnDzbUe/4441Gp6mzxvrzQSO0WDsG0e2eBC+rAUgxFOe6G9fCMJUqdCHzDBmwTt8
 fTNQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793091575; x=1793696375;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qp/foBD5Cj5Fy5uaSui4SOawb1JHTtbAOgjfS/g7C1M=;
 b=OdcHo4XOWcGA/NGfgBnM/GNGBBRLsJbB1ChOX3ZhXcsDgW2sha8WYuNezKnkHr/gyl
 vhEqen68vykfXGztZJ6jNbVba5nnXJx6F0nVoYZ8srw8n2ANUGTeBRc1tSy2FU6t9EdN
 fIv6kxVItpoa7UPrDZJl9xBBDuFjJGn9ynAOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793091575; x=1793696375;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qp/foBD5Cj5Fy5uaSui4SOawb1JHTtbAOgjfS/g7C1M=;
 b=V55Th5Csdw00hoDkGSZS3dUVq1oQiL5NN/tqD3bJPcjEXt2EtS0O3/A6QR2r/hJ5Yx
 CND1/vX1d4cQQd69VL1x/Ul8GKGbL2qOf3qf0GLdCSR/F5RowwxASwFit+UEsFpGyxrF
 VWVkwWQDXrb7grybLf+ir8iqr5Txs+uNrnRdU0ut60JeRdWkKE9/+wjH/e2UgAsSGOdC
 Pw1ndc8ZgDM60FmvlJYpApZDmDGzwYZrQXycu1JU6P9CP8u3waKT2VuhK1z9pnIE4+mH
 /vikgAF0xqbK21RL0khIx50QlE61w0z0iJ2jUyDFPoA4d2AAovDyHSu1m3lcB4yYFuFG
 SphA==
X-Gm-Message-State: AFq9FYK5ZYKw8EQ58S1nKX6K5lD2vvocfJPqxAKVcIZr9k3DivfPz8gA
 Jbck6lfkxLOvjgu8XJ5d9vKc+ngtu0sWIXT10MXxlr4AxqYvrt+wWoefbngyA7sg1gWQxrZCP2S
 VShucOzReZ3swzSphq8cBVY8orKrIodOzh0rtTbZ05XtHW4y01sTeQA==
X-Gm-Gg: AYBFou041T4LsTyjJBSgtFgv4ak3v3twwPckE0dEFwflep7BPgnNr3hbDZGY+q7Ccx9
 bMQxokYth7Mz++8XQdZtO++OrzTTDo9FU4F+jtImM6xiRUjRVidXj6r1fy4BIvsUXw0QKOGbCog
 kFr7EL4c1RziX6Ri/1C4onebA5xXhE06c7UABANfnMsJnlcWihTUTkuxHD4nDUB7dx8/rGHGuC7
 6DRW1dSuwvpO/RQFso+cbEzkOJIfn1Qc45xQzJ3fPqRmAwN0yvScUPx4KX4QjfZTVyzDrSaHlbG
 bZWQWQVztyV2KIjW4JmqC5DkJ++0d+yvYRBrPESHsfeOEBCeqKM91VTXGncYTr8pcub0LpWgX2H
 eirUW42/uxXfA+0n70BINEna8U8Gk4XNDaNGrD/28E0kS2Wznjg0NvLgJ
X-Received: by 2002:a05:6402:1356:b0:6b1:e097:559f with SMTP id
 4fb4d7f45d1cf-6b442ff10a0mr6561968a12.18.1793091575165; Tue, 27 Oct 2026
 01:59:35 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 01:59:32 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 01:58:08 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <720167ce-9e06-4425-b745-a1fde9954860@gmail.com>
References: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
 <720167ce-9e06-4425-b745-a1fde9954860@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 01:59:32 -0700
X-Gm-Features: AclHuK_7F69tT7lmNYZJszMmGmOL4H5igBDgqLFR1XzIxwsuLz4_yZDB9I2BKkc
Message-ID: <CAFLszThDveruJHK+fD50E8JWK_pykfuc2dghs_piCN=HPs8eJQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 7/9] disk: part_dos: Walk the extended partition
 tables in a bounded loop
To: anabobillo3@gmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana,

On 2026-10-24T12:16:28, Ana Bobillo <anabobillo3@gmail.com> wrote:
> disk: part_dos: Walk the extended partition tables in a bounded loop
>
> part_get_info_extended() and print_partition_extended() follow the
> links from one extended partition table to the next by recursing, and
> stop at MAX_EXT_PARTS partitions, the limit added for CVE-2019-13103.
> But a link adds no partition: an extended partition table holding only
> a link back to itself does not advance part_num, so the recursion goes
> on until the stack runs out, whenever a logical partition of the device
> is looked up. Even within the limit, every level keeps a buffer of one
> block on the stack, so a long chain of tables on a device with large
> blocks needs megabytes of stack.
>
> Follow the links in a loop instead, reusing the one buffer, and stop
> after MAX_EXT_TABLES tables, as many as MAX_EXT_PARTS partitions need,
> so that a disk with as many partitions as before still reads. Linux
> bounds the same walk in parse_extended(), by the number of links
> followed without finding a partition.
>
> print_partition_extended() followed every link of a table, where
> part_get_info_extended() follows only the first, so it could list
> partitions that cannot be looked up, under numbers that clash, and its
> walk was not a chain but a tree. Follow only the first link there too.

Since you are likely to send a new version, please can you use the
present tense here ('follows every link', 'so it can list', 'its walk
is not a chain'), since the code still behaves like this before this
patch.

> [...]
>
>  disk/part_dos.c |  41 ++++++++++++++++-------
>  test/dm/part.c  | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 130 insertions(+), 11 deletions(-)

> diff --git a/disk/part_dos.c b/disk/part_dos.c
> @@ -135,10 +142,13 @@ static void print_partition_extended(struct blk_desc *desc,
> -	/* set a maximum recursion level */
> -	if (part_num > MAX_EXT_PARTS)
> +next_table:
> +	/* bound the walk */
> +	tables++;
> +	if (part_num > MAX_EXT_PARTS || tables > MAX_EXT_TABLES)

The subject says 'bounded loop', but in both functions this is a
backward goto out of an inner for() loop. It works, but it is hard to
follow, and kernel style keeps goto for error unwinding. Please can
you write it as a real loop, e.g. for (tables = 0; tables <
MAX_EXT_TABLES; tables++) { ... }, with the 'follow the link' part
setting ext_part_sector and doing a 'continue' (or a 'break' when
there is no link)? The code that finds the next link is now the same
in both functions, so should be in a helper.

> diff --git a/disk/part_dos.c b/disk/part_dos.c
> @@ -28,6 +28,13 @@
> +/*
> + * A link to the next extended partition table adds no partition, so tables
> + * linking back to each other do not advance part_num. Bound the number of
> + * tables read along a chain as well, allowing as many as MAX_EXT_PARTS needs.
> + */
> +#define MAX_EXT_TABLES MAX_EXT_PARTS

One thing I'd like to check is what happens at probe time.
part_create_block_devices() calls part_get_info() for every partition
up to MAX_SEARCH_PARTITIONS, so with the table in your test each of
partitions 7..128 reads 256 blocks and prints '** Nested DOS
partitions detected, stopping **'. That is about 31k single-block
reads and 122 identical lines when a USB stick is plugged in. It is
much better than running out of stack, but it would be worth bounding
the number of links followed without finding a partition, as Linux
does (it resets 'loopct' when it finds one). Then the limit can be
much smaller than 256 while still allowing a long, valid chain. What
do you think?

> diff --git a/test/dm/part.c b/test/dm/part.c
> @@ -248,3 +251,100 @@ static int dm_test_part_get_info_by_uuid(struct unit_test_state *uts)
> +	/* and so does listing them */
> +	desc->part_type = PART_TYPE_DOS;
> +	part_print(desc);

It would be better to call part_init(desc) here than to set part_type
directly, so the test also checks that the table is detected as DOS.

Regards,
Simon
