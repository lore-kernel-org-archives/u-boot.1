Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B5C606A334
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oTCl5mYk;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.a=rsa-sha256 header.s=s31663417 header.b=pwwgH+2L
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B04A80E0E;
	Mon, 16 Nov 2026 20:24:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m7Ax18rJYM3W; Mon, 16 Nov 2026 20:24:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 98FD280E25
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794860643;
	b=UOGhOKxr3NlKp4i7th/9ITIABRiM4ofiWFpVobg/WfKLisIQ5/dzXI/ipcHixyjqzYzh
	 +kgB4ugMLzWv6Sw7mzZJVlqncavBqfqGL8c560XMfjWQnCUju/wopMw+7spvmpmNDBSSa
	 QvrfYu8OLhXtQ2m7DzHeCbnLJfYMZOUtNWOstYA6PCfxT0BbbkYMMcR81US3pYYxJHu5v
	 tIJRIJy+hzRERlXMV/8Fi0R4qbiXZBQGZ5apvyK/VMtYCtMS/1KE65p3Y9JV16MjqmMuN
	 n0TPEGjPuThs4Wz/8ua9SzZqvVDr/Xz27jldqLXMMQpj+0XSt2xaNZzhGIK4meAxUAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794860643;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM2-Signature:Message-Instance:DKIM-Signature:X-UI-Sender-Class:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dsKr5ZfhmXB38JObtSueyJLHs7K62M6vObkAOlT5WXU=;
	b=B7YStVzmZOmdl5IKZ4roZqzjOTtv8PuLrI+EcA5pkyfywDNXgtd9lcEvXnc3xmmCjOfv
	 njo0feM3YPdVL/DFuWUArPmuGnKGPSehBHjIpLOiLd5sO1izQ6eSYN4EOhKL1dsUefU+C
	 2GRbMGDihyjkOETst1atauH54Y/NK/9y4wNlRJj98z2TcMW46WfV4IFcjBLW7wlTe9LJE
	 8Ayl32gbDeTsDIVtwwg4vAx/NkS8VCdelCFwxcaCCPnH0haxCaniHEJiw1p22SjJIIAYv
	 3eniQQhfEVCLBgWl7wHDhpSXIC0oVLUhXxJ5KYaZIpAwT2s9v8IVkIGedvARFTVe2Kg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794860643;
	bh=dsKr5ZfhmXB38JObtSueyJLHs7K62M6vObkAOlT5WXU=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oTCl5mYk8pD+sz2Q9Dhcthdz+oYgZDYQhpryEW7aB6hIl0bNqQhquRIre2Jw9PeTG
	 6tnbmfjK7RlyzO1Orc5gNIy0OaRDYiAQeMIN6oRsA0Qfe/E/FmggbAE9iePbayvpHq
	 AFqk8ghwAX86FTVPUlNS/Yk4J9//qZgPwaUJJ9p7pbaPTVEJD6rDxv1XT2Rk1vRJxb
	 qbA9fzLb1Nzt9hWI8KPfCdohJzZZWgxNAb3m+kzxQrES6pX+0lC1IZ54vXlhgeTt7L
	 my0wpJJHVvEMYnyIU3+wd/Xhd/MI/PzPnEyk+1IzEhpSGGiKA6hxBFbyWGvrK+B4uZ
	 /NopEQJpuE7Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98FD280E25;
	Mon, 16 Nov 2026 20:24:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id ADA1D28C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:24:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F4D2405A2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:24:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y6QNAwAE24eY for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:24:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E4E0B40588
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.227.17.22
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.22;
 helo=mout.gmx.net; envelope-from=quwenruo.btrfs@gmx.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com
 header.a=rsa-sha256 header.s=s31663417 header.b=pwwgH+2L
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E4E0B40588
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:23:59 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1794860637; mf=PHF1d2VucnVvLmJ0cmZzQGdteC5jb20+;
 rt=PHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmc+; d=gmx.com;
 s=s31663417:rsa-sha256:OSZaKF6geg8MexkLu+KxifAwKG3D
 0emL7w+0DPddW0HYhnRghR38cFXzgnf6DAa87DJ0nyJmyGyCmZNp0bmdlhrcyrOSlqgqp/frGhw
 xalmcZhKeERboTRMs8p91MTZsUJc7fL2bq37fIY/Ab7FZAbfDTEIOdntvhPf751ELXNSIY4Nm1W
 j1FUq3LFM08iQi7X7G7guLU8ubiUaunnQTUfMqm3+YqwVvKSOmvqr9eQHnIVrNL+4GRHiNlK75H
 u4s/+JRKDcMKc2c30jftx/4248P6vbDcNQy/kuq6oJ39yZe/OO3v/a5sFhzWPhucU9Lobiu54HZ
 o49Uz5bLheDJIg==;
Message-Instance: m=1; h=sha256: tBIrw1C1rIIXNs4ttM8nlL6bsgziwkul2a9JaIuP9Uo=:
 XaoE2froyf3KD/FaSfsp9bnvpBC+oZdhwHR6mMdelyM=, sha512:
 FZInmpnl5In9Fzfae+z5v8hfZLEgQVaIHhTOnzNH48u9TQ7FQcT+SOMF8OfxzLSOEW7i4hCnNRxtLKFpAJkVdg==:
 +sRqAAgDKuYHC1P0FOBkW4Rxc9HdnxrXB3eSjzGAiHBBSOYYkFu54KKk9AoFTm0ZOMySqR6aM97xyYwq1b7Mrg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
 s=s31663417; t=1794860637; x=1795465437; i=quwenruo.btrfs@gmx.com;
 bh=dsKr5ZfhmXB38JObtSueyJLHs7K62M6vObkAOlT5WXU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=pwwgH+2LNO9/TGjksLCqoqNW4uC9gC0IlMwJEAyNY41a+xk7V5IbBJBO3UfFmH26
 2n0ty7VA1S3EC5Xci1lgQgIxdAF81SKsTWbjMWCFIzZEt/wTcXq2Cof7AYIw1q5TZ
 2cHLbFsjXJTdaSg5vYo1vKwYcxXQ6sX0yWOzGvD0sN+lthxAmovIljcZJv3PWXGxg
 n8/DWY2OVwW1KSjv9XXy6nKEBrT2BAjTKqnUmgqSzh6A1+Jss4mj/pjeOFfPZFVpc
 wJZq6yxNkJ+CUtLSsIwgin5JKzPOSNa38RY5STYd+FJS1Ibarec+QIY5T7k4SraUk
 abPzs5IzOizRrX5pwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1wpt-1wR1bI0Mpt-00wTz8 for
 <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:23:57 +0100
Message-ID: <d982023b-dac7-4407-96dc-893742aed104@gmx.com>
Date: Tue, 17 Nov 2026 06:53:54 +1030
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Five memory-safety issues in U-Boot filesystem/partition parsing
 (coordinated disclosure)
To: u-boot@lists.u-boot-project.org
References: <CAPmzV5kAUpHf5fGDHmQXnyDJxs=Kvgtks2ztva88pG2wj7m9qA@mail.gmail.com>
 <deff7930-1571-43fe-8f05-0c576e115c5f@suse.com>
 <20261116201914.GK554944@bill-the-cat>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCat7o8gUJFKS8
 OQAKCRDCPZHzoSX+qAogB/9C5ErH7KGAGpcLPte3Wcfdt3acCkGAuMpCjqOt8BVw30mX0kmF
 SRo2nODjz8YsYhWR1T8L3ylANAS/IGIJ64idBmObaqGHQn845nXLIvG33LqMsAGXmOJdRgTT
 BnBA+QFCEIZpo7L9Qt1dOQdHSpHT31Ta1kKsbDm582KPVBl6KRcJJBnjudIerOA1/L/zEyDa
 YjIfHIcvuM3Xm8AS00iBpsmc151QgCPljqnSRXBiup9C1oMgVlaROhY1iDam4UIQB6glkHQs
 LZhUmFDNimX5LxfOzi2pFJSjJvPclRZVX7Sq6XhK/OFb6IvswN7i0nUYZMQfuGDNqGn70ic3
 AQImzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCat7pCgUJFMw7KQAK
 CRDCPZHzoSX+qEjbB/9crFFjips2NKxkt2XUutUIKjBoUlg/xCeFIj8PsTuJePhrV9HzgKsa
 rJgSqo3t78oQWmeaP9WPoDYjfhOkQXEs+G9UwHe/LENm70+Q1jrwY3nlcR3YrkDCJ+EvMZOW
 ackgcOYn46Iri9DN91FbSTszPMnwHi/nf0aeJXicO9krrY5C8mUxv4CSKeKSRg/5BR59uDiy
 9CMRHDtIDnpDWaLOXtUeowCdiC5O/jA571PMFx3Aolc7g4SSyNbYodblCBOdJrh0CVm2LlQW
 3SXrvFpSAw7LMVDgsS8pTRt4A11eTIS7mz0zqafTohXP1wt+575IBHK5ZpThQb+PzSQmxAqa
In-Reply-To: <20261116201914.GK554944@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cla5UZ4aHVuQ7ioCnfWHM7DtWtQyX9mmdPkF9yBXClpzxm6w2dK
 hnEtEXJP1wKpkp35O0s4io0gXUwTeZlvtKHFg85i+PfdfXzIujW34dVnRyzarZ3pd3TpTSX
 d131hOT7DM4c4eOMETX9js2ABpSzGhvY/Xy6mZfzv9eH+bL9iCtD3YW3kaw/z+m5ehLznkA
 vQyjpcXW30woq6ERBjq5w==
UI-OutboundReport: notjunk:1;M01:P0:8R0kx6Xz0gA=;+ULMvKkbKDXfKwIIvD8gHU5BkvZ
 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
 1Sc=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



=E5=9C=A8 2026/11/17 06:49, Tom Rini =E5=86=99=E9=81=93:
> On Tue, Nov 17, 2026 at 06:44:56AM +1030, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2026/11/16 17:24, Dilip =E5=86=99=E9=81=93:
>>> Hi U-Boot Team,
>>>
>>> Thanks for all the work you've put into hardening U-Boot's image
>>> parsing, the 2026 squashfs/disk crafted-image series was great to see,
>>> and it's what prompted me to take a closer look in the same spirit.
>>>
>>> I'd like to report five independent memory-safety issues, all in the
>>> same threat model as that series: U-Boot parsing an attacker-controlle=
d
>>> filesystem image or partition table from untrusted media (USB/SD/eMMC/
>>> partition, and for some, a netboot-fetched image). I found them by
>>> source review of master v2027.01-rc2 (commit ff8a9bc4), and each comes
>>> with a minimal, self-contained proof-of-concept.
>>>
>>> Reachability for all five is an everyday operation on attached media,
>>> `ls`, `load`, `part list`, `cramfsls`, `btrsubvol`, or distro-boot
>>> scanning,=C2=A0 with no signature verification anywhere in the path.
>>>
>>> Here's the short version of each:
>>>
>>> 1. squashfs: out-of-bounds free() in symlink path resolution (CWE-590)
>>>   =C2=A0 =C2=A0fs/squashfs/sqfs.c : sqfs_clean_base_path()
>>>   =C2=A0 =C2=A0A symlink whose target has more ".." components than it=
s path depth
>>> drives
>>>   =C2=A0 =C2=A0free(base[i]) with i negative,=C2=A0 a wild free of hea=
p pointers before the
>>>   =C2=A0 =C2=A0base_tokens[] array. The `if (bc < 0)` guard only runs =
after the frees.
>>>   =C2=A0 =C2=A0PoC: ASAN heap-buffer-overflow at free(base[-1]). Trigg=
er: /s -> ../x
>>>
>>> 2. GPT:=C2=A0 integer overflow in partition-entry-array allocation (CW=
E-190 =E2=86=92
>>> 125)
>>>   =C2=A0 =C2=A0disk/part_efi.c : alloc_read_gpt_entries() / part_print=
_efi()
>>>   =C2=A0 =C2=A0count =3D num_partition_entries * sizeof_partition_entr=
y is computed
>>> in 32-bit
>>>   =C2=A0 =C2=A0and wraps (even on 64-bit), under-allocating the PTE bu=
ffer, while
>>>   =C2=A0 =C2=A0part_print_efi() iterates the full unbounded num_partit=
ion_entries,
>>> heap OOB
>>>   =C2=A0 =C2=A0read + partition-name info leak. PoC: ASAN, 512-byte bu=
ffer vs
>>> 33.5M-entry loop.
>>>
>>> 3. GPT: unbounded header_size drives OOB CRC read (CWE-125)
>>>   =C2=A0 =C2=A0disk/part_efi.c : validate_gpt_header()
>>>   =C2=A0 =C2=A0efi_crc32(gpt_h, header_size) runs on a one-block buffe=
r, but
>>> header_size is an
>>>   =C2=A0 =C2=A0attacker-controlled le32 with no bound (Linux rejects h=
eader_size >
>>> block_size),
>>>   =C2=A0a multi-GB OOB read before the CRC check. PoC: ASAN read past =
the 512-
>>> byte block.
>>>
>>> 4. cramfs:=C2=A0 heap overflow in symlink/data decompression (CWE-787)
>>>   =C2=A0 =C2=A0fs/cramfs/uncompress.c : cramfs_uncompress_block() (+
>>> cramfs_uncompress_link)
>>>   =C2=A0 =C2=A0avail_out is a fixed 8192, unrelated to the malloc(size=
+1)
>>> destination sized from
>>>   =C2=A0 =C2=A0the inode's declared size; a crafted block inflating be=
yond `size`
>>> overflows the
>>>   =C2=A0 =C2=A0heap buffer with attacker-controlled content. Present s=
ince 2003.
>>>   =C2=A0 =C2=A0PoC: guard-page SIGSEGV at the allocation boundary. Tri=
gger:
>>> cramfsls over a
>>>   =C2=A0 =C2=A0directory with a symlink.
>>>
>>> 5. btrfs:=C2=A0 heap overflow in subvolume path resolution (CWE-787 / =
120)
>>>   =C2=A0 =C2=A0fs/btrfs/subvolume.c : get_path_in_subvol() / list_one_=
subvol()
>>>   =C2=A0 =C2=A0strncat(path_ret, tmp, PATH_MAX) accumulates the path a=
cross the on-
>>> disk ref
>>>   =C2=A0 =C2=A0chain with no total-length bound (strncat's size arg bo=
unds the
>>> source, not the
>>>   =C2=A0 =C2=A0dest)
>>
>> That's the biggest problem here, unlike kernel which has VFS layer hand=
ling
>> such overly long path, here we don't have anything that limits both the
>> source and destination length.
>>
>> What we need is strncat_s(), but it's not provided in the current code =
base,
>> so you may need to create a dedicated helper.
>=20
> Is there some helper function currently in the kernel we can borrow?

I don't think so, mostly because kernel don't use a single buffer to=20
record the accumulated path.

But it shouldn't be that hard to craft an equivalent of strncat_s().

Thanks,
Qu

>=20

