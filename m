Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E087606A31E
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WXKy+Stf;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X2UHC3oM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 657546082A;
	Tue, 20 Oct 2026 13:21:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7SWwn3vNU2MF; Tue, 20 Oct 2026 13:21:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 855EF60794
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792502498;
	b=otGkV6aF/Zw8ZGBOIcbh6k5zDZxzMbKBpNXFZ5t86G1yW/A2ii7xd5h2Uwh2DjtqzmUx
	 8Sl2sXTorWZj4erfkkFgznpnhwIsbkhy2AyMPr7ClQj6rw0Ke40S/3nk/srtZqBbssXbb
	 GuzwysFEoiFg67ZdSqxfPbyusckgG265rhgNUXr1bzbrZWeaGfHmCLQLUyR0+ZAURTsPw
	 aoPz0G5O/ZaFV4W5P1m+mx1RszrGwryoIqoM+a7oK6Ik3IYXhIHajEY0SMn1MvkUgKepc
	 MTCI0ucG3HjN9iEW516N8ASw3Nr7qiJrBMx5LDz/LyeeO4VB6Zak9JkbVjPohj88rDg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792502498;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PFCkPAS5aEBjg123IyClh9eN44Ya4vONzIsSP/m9wz4=;
	b=ictaMaNEYdccaKSDvZ9Sz62bRCpbkDnQdegSv8rp/NZFPITyVlc9z6P9TaAabVO5J+67
	 Rlx5o9KEBdVn07XVhiEZUpHe6EwrzIVGaj4ZQEKO81L9WiCbTmbwUtNQaspvo9tHS4Ull
	 MYO6AA7VAdrAw9eS9G++eegEgYXzG/wYENiLm60xOeRC8/LOl1Gh4aiUWYaocY8WvFSTQ
	 T52VNiBY4WE0SZ6JyLUF64DQJP8gzbsUKXNIMS4Oaz6ioezh7C0DhS1Sw6W9GByR0o9fh
	 E4UzBF5e+t7h4RV5Z/dgfpaFHEugL5WBlnkZv/SvzllzmeW5uOP2AYzzX9q9btTHQ8A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X2UHC3oM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792502498;
	bh=PFCkPAS5aEBjg123IyClh9eN44Ya4vONzIsSP/m9wz4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WXKy+StfF3Tz4ee9cPoIIwYKNlS/32TJOVnKUOZbno4etunSa56qs4b8EPItyPvpT
	 2YzX0rhC8WS5p/9PTMb8arv5/CD/H+3VbCWtqLng1Ul7MFBkU2A7xyfYRzZgbdHni4
	 xWhA5/lLZypv0YG6pRxTE7SJoxb18KkVDR80JaFgDWaGRrP4UclT7yMIDo+vzloIBY
	 7pdkCjZwjyNVBk2TQgb89LvDZ9tUvNJaC7ubLUBM8oI09b2Ua2gT1hE91gM334SwmQ
	 6YDpM4f389i4w/iKDtKhSmS+PmKzrLQn+3DvhqaS48Yg0l922qXSYDqe/NlTaP7k6D
	 aL1GilvdnkUag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 855EF60794;
	Tue, 20 Oct 2026 13:21:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D814C1AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:50:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BE20C607E2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:50:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oLGdTFKXjzxQ for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 11:50:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C12B0606ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2001:4860:4864:20::31"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792497045;
 b=ptxWtDRzyTvCStaInoMjbl/HcUP+gPEpvchPcHi+FoABqkYVVg/K8c+JKn8X+Zt4c5KL
 SMyLIJus0L4ZaDaBRrStCNrXNvUpG39AeYz8Nr01x0y3hnu/SyAceXilsFvnDdlvcvYU8
 PJQrh88nsIXSDw05BTFt5v6AgB70X7ErJy7uAtTGG2jefQPmVAjWnHUWUgusuEBOpEQZC
 7NBzJYCte5MOx5yMzsC9oaeJYwUd9rCqnCyVzEMj37aiegUCX1ih9jJkU9KQ7WyuR8a7G
 nYfQ7XVy42WrmZDRybDz1ILp4QnUp6XB7jkBc/SwVmC+yLdb7WiZdF6BCQ//nxgvr2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792497045;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=PFCkPAS5aEBjg123IyClh9eN44Ya4vONzIsSP/m9wz4=;
 b=e+RshwIN8TmW+gY0tJc7YTgeK39WHdJn5JV3nz5F6FGbGGbiJIH0j0w9huOPGA7lxwyY
 j/0fL5jtqFLNzVcF9vdSSFUTdD7v276hVyygkkQs51hvGh87Okw0NKAi26BeftNaVE4qn
 nLso1b+ro/Dj2q4A5OC9EAiLmwe5h+xZJIoP0aYaKuYDb6w3eZmYTVxoEtY0kWU6XWBqr
 vZKhsmi1uCs+6j7WHhcGGj+LyCaNQQPIKSxVZgQ9Nio//GoEImK4SasqvwXrXKRXdAMBu
 j1f0MKZQUjZk+Zj9gw9KscVXuuUx+N0gOFLDTWTJxkx9brFZVEHCOOS5Pd0eDi1dfOQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=X2UHC3oM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2001:4860:4864:20::31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::31; helo=mail-oa1-x31.google.com;
 envelope-from=nimeshacharya197@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=X2UHC3oM
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C12B0606ED
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:50:44 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-4877837890fso1521535fac.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 04:50:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792497043; cv=none;
 d=google.com; s=arc-20260327;
 b=lO6C2+0gSHmdRTwpoB2gfa2LaXNSA55BID00DA63jOiPjYeb7zOaE0np75KLJnQDco
 gjrmBGHOyrFf0YgJ7Z/66dP2MQ1dZDwPJuwUw5FnEhuP+tXS41dv1P4pNwmi8J7Qi+B0
 ja5WNYJywspgj7lEtUMt3bSraMox+sE5/3ErIMJTd6zv3MEUxb59HcHLrvTccIr428y3
 2YevnlvJ4jI3q6sThGSim8eDfAWudySSL5s0VObR12Q13XqlwqsC5Np7wdvek8briPll
 /lbpxjLEr/CL8zgY22WEL/Up5cB8LsjDFGiUxDjnSeJwj4gPVUrOGAI4ar1E3OkcVEw/
 lFoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PFCkPAS5aEBjg123IyClh9eN44Ya4vONzIsSP/m9wz4=;
 fh=TZrJx8+rBVlJQSwLpLlVyKQ153mHgAA8FwEzAMMs/yQ=;
 b=lpbHd8bHqDYJfcE9Wa6PiFtGWogTQ/RZ2UP9P13cD8Reru2Q3hIL3qKjHoLKpNN/Tt
 16qi5sOQ5WiP50FDMkNQaJ4reAnB1yUorAyLKhqH2+s2WdvZ7wNKlRz9UIColFzh2ZWk
 GObz6+ql5O0UcwC6J94ZmBSS5JedKEwP5B1zLNcVgKdf7yj62iOuH4L0/7kZZbPQlCk3
 vUR+vzEpmDZW9rDh5GX0ZkHq3+n6Sxnf4mn/ROs5QxuC01LOdMqSoBEEH03xrjiky/IU
 bCc2aduLJiQk3JEq43GJISHdA8h4MSKmZbtN1kSCg13DBagx53h474Y45y4ea4qwTFqK
 vNUA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792497043; x=1793101843;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PFCkPAS5aEBjg123IyClh9eN44Ya4vONzIsSP/m9wz4=;
 b=X2UHC3oMXOU7QMa4WS1NL11oIWM34yBLIMqPapYR6zZXueLv/dOHVPBx2EQGVAiD88
 0daSXUETnsOkBP+necJfjOLr6P4hF21kaE0UK9wBjpFo0wvQD/2InN5wSttiiHlqowX1
 p7DigM2ChUxRtNZR/yaHjkdUlRAwmd/oOeQgCrmraNZevOH4/3n1yn/L/GcJmuF8q13i
 wV1c6ZCPJwYF+Cdz0ng387mRAS+BSAAr1niBoP6bjipxmmmw9HsCnPqDWQ+2Fg3v2IM5
 BvnV1GrsZC265zwFRugFiAs6dntMmVHbQdH6XzNcWDFbHNTjkYLRHKc4YMrjRJvht1dj
 s3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792497043; x=1793101843;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PFCkPAS5aEBjg123IyClh9eN44Ya4vONzIsSP/m9wz4=;
 b=bSBlzTZZkP2MagwNHst8pmy6pSpy6UtbmTbmXoEKeCvYNa6cTh5nlYj8YAJKI5syg0
 KgICOHrGGR4BE+IZrUQtvH63LQRyCEB8yFQNA4qIb0Z006rDATUDoyoPCe9mkOyqXxEb
 vPM09G2vTfi4k7A8YacS5bDhdR/5p24V9Mi4+jsxFmWnLTT1KimjX8uZz49bfZDge6TD
 Fsdm7baBBZBlMcx059hJH4Oc+EKU3fsxVHZE6MBllqQ19B/l3muzIhSlI/T66dKBr9us
 1nVZ+QWKF59CnOsJZBPkzdNBYmdWgCxQKNaiSmzY9Di9Y76jLtULkLBaiCE2vyFydFF8
 +8xw==
X-Gm-Message-State: AFq9FYI3FVrGj6fFMB5Bkm5D9MMpJfqSPsl17Ukw58Si7ntLmwh0M/Xs
 GjHRtn1lzwHDmSi/3iA+PCiTwyc8JIWTxvYDQ5HrmkcGGHkjg88JncTr31deylqXsqYELwXmm9X
 pdmi0ZkbanumDCOiqog/rXVDHAWfrX3c=
X-Gm-Gg: AYBFou0r+lrRwrwH6/eMm1UiyG4GZfKmhqSG8vFOuoR7fCiV27OVzg7zBvefs0H7sOo
 HqeB4DDceyJhDVaYByABLTRlMpRc6hhlzq5OYV0i2f7lm7B0Qd8Iisape5J4/6/GlJuwwlEnDkH
 7Sa3KE6IKcnCMIChHS03Vdx2Sr1wTB0jq5uwvh2FqsvdV2Qq27QarwXrkXwZOELL89+7G+LT/53
 4VlVqhAQADsIXjB7ihMPDq0MQrupZoVuIMi0I5JUoUxCFThC9P9OyJZKO2nc6YL02S6DaNyon69
 3vj8SP29JZJoI2T+IUoR0pzrCLDVNtNppCXEJ+1H7Ss75KyovbJji+LGMMSednUAwRjvqM8zJUK
 v2n3g6p1NU8begeZBTkcQTY2mZIbO9DBBPn7qbhNSc6Q9lEu36hSmXy3ov5CENpmg3xDKlT+gj/
 H8tgSn0zoTDiCQ
X-Received: by 2002:a05:6870:b3e2:b0:49e:45d6:feb0 with SMTP id
 586e51a60fabf-4a75789dc38mr8597776fac.20.1792497043118; Tue, 20 Oct 2026
 04:50:43 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019205932.28038-1-nimeshacharya197@gmail.com>
 <097d4df2-1142-4eaf-b23d-60f2f4e291cf@mailbox.org>
 <CAMb=oEaXycpsLz6wfxKVqucox+ZuJumMgaz3Q=+dfD8R3o804g@mail.gmail.com>
 <4030a7f1-c924-4d51-bf93-eaaaf8df2ed0@mailbox.org>
 <CAMb=oEYbdBJbQ-sjZ5q5YDXSjgH3j5PdM11smGXxqgGw-e7QQw@mail.gmail.com>
In-Reply-To: <CAMb=oEYbdBJbQ-sjZ5q5YDXSjgH3j5PdM11smGXxqgGw-e7QQw@mail.gmail.com>
From: Nimesh Acharya <nimeshacharya197@gmail.com>
Date: Tue, 20 Oct 2026 17:20:29 +0530
X-Gm-Features: AclHuK-roB6_NiW-yqe8AiqTluCbsUfRUSQmpgANBYTs8QT_ytxPK6nR7qrgiNA
Message-ID: <CAMb=oEYVa1sbbav5HAzotyLmh5iiysjOgsyoTOp4BobJ0ShufA@mail.gmail.com>
Subject: Re: [PATCH] configs: socfpga_de10_standard: Fix raw partition booting
 from SDMMC
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, hsnaves@gmail.com, 
 marek.vasut+socfpga@mailbox.org, tien.fong.chee@altera.com, 
 trini@konsulko.com, simon.k.r.goldschmidt@gmail.com
Content-Type: multipart/alternative; boundary="000000000000841cac065e443d48"
X-Mailman-Approved-At: Tue, 20 Oct 2026 13:21:32 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000841cac065e443d48
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 5:14=E2=80=AFPM Nimesh Acharya <nimeshacharya197@gm=
ail.com>
wrote:

> On Tue, Oct 20, 2026 at 4:14=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.=
org>
> wrote:
>
>> On 10/20/26 10:35 AM, Nimesh Acharya wrote:
>> > Thanks for bringing that up. In fact, on running grep -E
>> >
>> 'SPL_FS_LOAD_PAYLOAD_NAME|MMCSD_FS_BOOT_PARTITION|MMCSD_RAW_MODE|SPL_FS_=
FAT|SPL_FS_EXT4|SPL_LOAD_FIT|SPL_RAW_IMAGE'
>> > $B/*/.config
>> >
>> > I get this output for the default config:
>> >
>> > CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=3D0xa2
>> > # CONFIG_SPL_FS_FAT is not set
>> > # CONFIG_SPL_LOAD_FIT is not set
>> > CONFIG_SPL_RAW_IMAGE_SUPPORT=3Dy
>> > CONFIG_SPL_SYS_MMCSD_RAW_MODE=3Dy
>> > CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy
>> > # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is not set
>> > # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE is not set
>> > CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x200
>> > CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=3D0x0
>> > # CONFIG_SPL_FS_EXT4 is not set
>> > CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=3D1
>> >
>> > So, me adding CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=3D0xa2
>> again is
>> > indeed redundant. I'll fix this soon.
>> Please stop top-posting.
>>
>> Is CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=3Dy the only opti=
on
>> you have to add ?
>>
>> In any case, please do a V2 and make sure the
>> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE is in the right
>> place in the defconfig, not at the end.
>>
>
> Both, CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=3Dy and
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=3D0x200 are to be added=
.
>
> Both of these values are not visibly set in configs/socfpga_de10_standard=
_defconfig
> nor arch/arm/mach-socfpga/Kconfig in the main branch. The meta-intel-fpga
> layer in Yocto does not set these either, however
> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=3D0x0 seems to be set b=
y
> default (as seen from the .config) which makes the default OE build
> non-bootable.
>
> The requested change is required to have a bootable system, and has been
> verified on the board.
>
> Sorry for top-posting and sending V2 too soon.
>

Sorry the mail didn't get CC'd to the rest.

--000000000000841cac065e443d48
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span style=3D"background-color:transpare=
nt">On Tue, Oct 20, 2026 at 5:14=E2=80=AFPM Nimesh Acharya &lt;<a href=3D"m=
ailto:nimeshacharya197@gmail.com">nimeshacharya197@gmail.com</a>&gt; wrote:=
</span></div><div class=3D"gmail_quote gmail_quote_container"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><spa=
n style=3D"background-color:transparent">On Tue, Oct 20, 2026 at 4:14=E2=80=
=AFPM Marek Vasut &lt;<a href=3D"mailto:marek.vasut@mailbox.org" target=3D"=
_blank">marek.vasut@mailbox.org</a>&gt; wrote:</span></div><div class=3D"gm=
ail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 10/20/26 10=
:35 AM, Nimesh Acharya wrote:<br>
&gt; Thanks for bringing that up. In fact, on running grep -E<br>
&gt; &#39;SPL_FS_LOAD_PAYLOAD_NAME|MMCSD_FS_BOOT_PARTITION|MMCSD_RAW_MODE|S=
PL_FS_FAT|SPL_FS_EXT4|SPL_LOAD_FIT|SPL_RAW_IMAGE&#39;<br>
&gt; $B/*/.config<br>
&gt; <br>
&gt; I get this output for the default config:<br>
&gt; <br>
&gt; CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=3D0xa2<br>
&gt; # CONFIG_SPL_FS_FAT is not set<br>
&gt; # CONFIG_SPL_LOAD_FIT is not set<br>
&gt; CONFIG_SPL_RAW_IMAGE_SUPPORT=3Dy<br>
&gt; CONFIG_SPL_SYS_MMCSD_RAW_MODE=3Dy<br>
&gt; CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=3Dy<br>
&gt; # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is not set<br>
&gt; # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE is not set<br>
&gt; CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x200<br>
&gt; CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=3D0x0<br>
&gt; # CONFIG_SPL_FS_EXT4 is not set<br>
&gt; CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=3D1<br>
&gt; <br>
&gt; So, me adding CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=3D0xa2 a=
gain is<br>
&gt; indeed redundant. I&#39;ll fix this soon.<br>
Please stop top-posting.<br>
<br>
Is CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=3Dy the only option =
<br>
you have to add ?<br>
<br>
In any case, please do a V2 and make sure the <br>
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE is in the right <br>
place in the defconfig, not at the end.<br></blockquote><div><br></div><div=
>Both,=C2=A0<span style=3D"background-color:transparent">CONFIG_SYS_MMCSD_R=
AW_MODE_U_BO</span><span style=3D"background-color:transparent">OT_USE_PART=
ITION_TYPE=3Dy</span><span style=3D"background-color:transparent">=C2=A0and=
=C2=A0</span><span style=3D"background-color:transparent">CONFIG_SYS_MMCSD_=
RAW_MODE_U_BO</span><span style=3D"background-color:transparent">OT_DATA_PA=
RT_OFFSET=3D0x200 are to be added.</span></div><div><span style=3D"backgrou=
nd-color:transparent"><br></span></div><div><span style=3D"background-color=
:transparent">Both of these values are not=C2=A0visibly set in configs/</sp=
an><span style=3D"background-color:transparent">socfpga_de10_standard_defco=
nfig nor </span><span style=3D"background-color:transparent">arch/arm/mach-=
socfpga/Kconfig in the main branch. The meta-intel-fpga layer in Yocto does=
 not=C2=A0set these either, however=C2=A0</span><span style=3D"background-c=
olor:transparent">CONFIG_SYS_MMCSD_RAW_MODE_U_BO</span><span style=3D"backg=
round-color:transparent">OT_DATA_PART_OFFSET=3D0x0 seems to be set by defau=
lt (as seen from the .config) which makes the default OE build non-bootable=
.</span></div><div><span style=3D"background-color:transparent"><br></span>=
</div><div><span style=3D"background-color:transparent">The requested chang=
e is required to have a bootable system, and has been verified on the board=
.</span></div><div><span style=3D"background-color:transparent"><br></span>=
</div><div><span style=3D"background-color:transparent">Sorry for top-posti=
ng and sending V2 too soon.</span></div></div></div></blockquote><div><br><=
/div><div>Sorry the=C2=A0mail didn&#39;t=C2=A0get CC&#39;d to the rest.=C2=
=A0</div></div></div>

--000000000000841cac065e443d48--
