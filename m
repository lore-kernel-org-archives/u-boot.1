Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDD1606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bxUtyEV+;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=DBy2fHPr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5B6E80C74;
	Tue, 27 Oct 2026 07:51:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bB93immL_Ti2; Tue, 27 Oct 2026 07:51:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 05F6180C53
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793087507;
	b=nlLSLcUfmMzGcanGalu7Sanh0WhiowbIQcIHQ2fFiNnVZs4aKCYB2WkSpSkHiBU+QZJL
	 A/iECQ7bH+nvDiEtchBWljaajuXL8tIJHpHLd55L84WUolVAY+orgKUM4fCHFcxb674L/
	 /AVAKZcirf2uIY2KEdRhJPaRAsYFXPzJ7J3rtuobSv0yuwM2C5S3Vvs5vLOYGmM38NO9D
	 QWBMbHJ1VP51hf5FibSKOMzSBDVJxUw+UsTzCFufTsgAUKnwhgQDnMzbudMsceSEnWg+W
	 S9mEvBU9MjkCS+CWdN9KCchrfD5vprxv5Zw7IuNKjsWHG303vSWcKgEsOn23nJt5wCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793087507;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=uufj+VBwEQuyOmbhauSbqtoJiBEwZr/YLVqnlyitbDs=;
	b=p2aAh0/3luPaymqs26o5kRp1YjQHWz+hmx7bUUofSFgjk/Tmg520qA3+bNIXaje6AhD6
	 BDlsVP4usR9zIDv5eK0DSesO4KOnaHCprf1goL2OQM08cQrOWdAduvTIVkphOFw5a8uBE
	 vsD670HD8OL+vjACgtsyYqw/jAzRA8iIP7urbgXHmDqk+yph8AgyACz6hjhrMq3zKtHmi
	 gcy54m4AEI0zWX/8GlLt779DRPna4d1YQIUXIC2sIF5JHNww3BgtYEnGNirOlcFrZFNQq
	 cWHySapbdPZrE4xehyrCvAuJsM1qDidLO1c0X6F5KwC45XMljC4PERs79XPA4QxikKg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793087507;
	bh=uufj+VBwEQuyOmbhauSbqtoJiBEwZr/YLVqnlyitbDs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bxUtyEV+P+gfNdvZPBIXak3mx3hFgOC0m7JIEHxcsHb04qoNEkWPKj07vDzVfgPXq
	 tKmoHwc417P1WbLJzjdnPCGBc3ptkH1s/BoCbK/S5ZwMmRXWvzWipWng2hfYUOjK6v
	 GjJZDPf2Uc9pKKJcVgF8t+6ecEy89EBSvcqfvvUjzr5BpqGd40i+NfRkXnNKxDtnq1
	 LGBKx7IcWKaWdCBxzlBHh9uOLi9zIPbEgEL2XX6IXqVKf3lzl2H9lcOJRGD1HfN+Da
	 ioj0+833C4OJHLhwU8V6HY+b5I8Bhu/WL7aTd7stzRm/EXpjcQ00rXRWVhoXJs7dGT
	 hgebdJkQ2R1OA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05F6180C53;
	Tue, 27 Oct 2026 07:51:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BC1072
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:51:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D71D606FF
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:51:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9SHbCmLyWzCe for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 07:51:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 537A4606FA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793087504;
 b=rGKZeoCpfNbCjU3oBt/jQgf+iUmcIlP9l25q7bZkirOFPObawV6LZGSdxA/QqIRRCVlZ
 BQzKuyqN9bpU3hzywViuVc01WbEygKkS7PyieGIMwL4xFcJTy0Oq7zvsh00Ax8uxyGaBz
 qUJPCYQxIXw7y7fwDvEH1IXlVoGnzKjx2GYClHdhs+G3I+b+YIq50bHJ0Hh55V/aACkkt
 vePMUcLEYaF3uXg31piXmV+gAnAD0dfya1EpFRd3bvqRF57sDHPxYj5u8nlHJjdUvzsEO
 liUnma1sFj7yn5lMN2TuKesAjEPaqR80Nh1GQ0v5GeZ/vTNMZirzG+jAuGVMlCcD/0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793087504;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=uufj+VBwEQuyOmbhauSbqtoJiBEwZr/YLVqnlyitbDs=;
 b=oOdZW5FAs5KXvrKooiobxuwk29RPkHyXv9lieK6y2txnssGHX0712dmwN+3tmSuozlCG
 Jj2WZbgfc6phsKP+HZTyH4WP5Vg9WZ0ry1I+Wk92a1wpGscy6WeO+gdIyFKKIjpoIFDJ+
 MmExWUEbqVfJuvV8jTt99txTr9WwlOd+MBt70XOQ4SzPD3Hvb2+v65RosJGFoO4J6GjJi
 1PXpArAVoBrx9JUz77cqhmWvol+2IPVVKk1JaW+/AquqLSZ780WJL6dZKmMnopZvW9P3g
 F1ltBO0hnGFXZhmiPCNTGu9Tegl6TlIEaOPi3dcVhOu45kl0Z2cFcE0htkL2qlpV8Lw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=DBy2fHPr; 
 arc=none smtp.remote-ip=212.227.15.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.15;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=DBy2fHPr
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 537A4606FA
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793087489; x=1793692289; i=xypron.glpk@gmx.de;
 bh=uufj+VBwEQuyOmbhauSbqtoJiBEwZr/YLVqnlyitbDs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DBy2fHPrdHEwn/CJ6BnCqqGBFwAtlxEppf/8R558rVX9zr6ZO2abMUkwdsamWyKV
 P+jE1ALgb/Yb2iflrR2xZhx41QgvH/TnVgDwlHnU1zQmWM3ZvUfGciwwJ8FrMwmqR
 diV6zL6LJSa0BquWbcsyWgrN1dKe0BnRyNhKCK56zNFU7s/nd5q4iyoh2kYUOxbse
 ecJHKBOY16p2Tpd9xbpAq7vhdtu3H8rr5dFiN0hRMkFn/qYou4Nba+KJFSzVrKNs4
 K/R1E2Dh8IeXEN7IdkgXY0YHJM5D8eJJMLBXv1XokRiGwUADFGNs963jSN2f5fGe2
 F0lBOxT+1WSUeqKVLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLi8g-1x3wae20sy-00QeTG; Tue, 27
 Oct 2026 08:51:28 +0100
Message-ID: <55c90ac4-1730-4089-b9a0-95de861c13ea@gmx.de>
Date: Tue, 27 Oct 2026 08:51:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Cole Munz <Munzzyy1@proton.me>,
 Pranav Sanwal <pranav.sanwal@amd.com>,
 Pranav Rajendran <pranavkasthuri@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, Carlo Caione
 <ccaione@baylibre.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Julien Stephan <jstephan@baylibre.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Samuel Holland <samuel@sholland.org>,
 Petr Hodina <petr.hodina@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>, =?UTF-8?Q?Jo=C3=A3o_Loureiro?=
 <joaofl@gmail.com>, Siu Ming Tong <smtong@axiado.com>,
 Tom Rini <trini@konsulko.com>
References: <20261027012709.GA2177077@bill-the-cat>
 <CAKTNdwFp68LxY2BrghRCH=kCcRf6Z4Q_v4zXAPgM-VFB4QbxwQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAKTNdwFp68LxY2BrghRCH=kCcRf6Z4Q_v4zXAPgM-VFB4QbxwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wfbGb9in4/FJJtmbIyfT1PMDBBgp/eFS92MRTqliyLvbx7CSKZE
 /7y/e9FuEP65KWVf1lXkxYv37h0woRLiPOJEs3YsblWYv1SkfSuDOLcJJrWYA4Igh5geDF3
 5WaO+ZVOR/RLJ84RjiDKR5kfv3TzXlfODUZfOfrCe7O72Dh3AoBGa3aIqKEOVLiJ3mKNqk3
 bMkUtzND964TtvPIW2NCw==
UI-OutboundReport: notjunk:1;M01:P0:58/1aHUYc1M=;QUlzKVIs56+4HDVyj+SZ1aNfJ/5
 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
 JuccY2U
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

On 10/27/26 08:19, Alexey Charkov wrote:
> Hi Tom,
>=20
> I've checked 661173 and it looks like a false positive - but one that
> is likely to reappear going forward.
>=20
> On Tue, Oct 27, 2026 at 5:27=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
>>
>> Here's the latest report. Since it says 20 out of 25, I downloaded a
>> report as well and the 5 not listed here are:
> [...]
>> CID 661173, String not null terminated, boot/bootmeth_bls.c,bls_boot
>>
>> CID 661173: (#1 of 1): String not null terminated (STRING_NULL)
>> 7. string_null: Passing unterminated string label->name to parse_label_=
keys, which expects a null-terminated string.[show details]
>> 309        ret =3D parse_label_keys(&body, &scratch, label, true);
>> 310        if (ret < 0)
>=20
> The string it complains about arrives via memdup_nul(), which does (in
> lib/string.c:357-358):
>=20
>          dst[len] =3D '\0';
>          return memcpy(dst, src, len);
>=20
> Apparently Coverity misses the assignment of the terminator which
> precedes the memcpy call and flags the string as unterminated. Shall
> we swap the order of those two operations to keep Coverity happy going
> forward? The behavior doesn't change either way, although directly
> returning the memcpy result (as it is done currently) looks a bit
> neater to me.
>=20
> Best regards,
> Alexey

Hello Alexey,

I marked the Coverity ID as false positive. I am not sure if Coverity=20
would understand a changed sequence. A tail call results in shorter=20
binary code length. I would keep it.

Best regards

Heinrich
