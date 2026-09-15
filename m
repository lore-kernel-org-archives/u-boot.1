Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3879AC88E77
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 18:45:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CD4D40367;
	Tue, 15 Sep 2026 18:45:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ProW8-l845V; Tue, 15 Sep 2026 18:45:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C73A84033B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789497928;
	b=UUTB7xPFYCNwl31UtSgC8kb/Uf6p80tdLtCH2KSGoLsFKgglIReXO3h+JeYniZpZjJh6
	 zoSTqWj6lGGrXZVXe+loteTlGuvipPVg2rTAkVrttAu/ProIY6kNrZEvdB1WqJfy3CpMX
	 26PF7x4ht6j/GkaJiJVDvRd7zQiweKAKxI8E5fmt8mrydlGzb3oKMmdTE1oS5Mypi/CJR
	 6ow3me+0xsWq1kM7FwAyuuBD0wrL6mGY1XFokEHrHNJ4Uh+ucpAUK84AOzTLtPnSCglXU
	 FTblqzTIyF3rrYnLp1bbSky/ENNFyjJAMv0HGGxFygRdOGcSWip3BpXVAAw/MLwdjmg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789497928;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=C99cZNU2yXVXNp4P5evkvQnMApiZN5Vrl+rHRNFtFTw=;
	b=KQaqrdgSV32Pvj6jN2YE6Ic8ThDq/5TuOF08UbflavoWStTYkaq6rHNaTHI4Hmi+5G00
	 S9hEvaJyYstM7uH78RhgSPs6b/dd0k8iTXdCaen166IBRFCPwoOoiA2BnQDalevWVowTm
	 TwSG2Ka/EtO1PCsDUJcbrwELbtvcK7dO9IGc7n37ZTe/T2AsOC9JqSVYb10SjC0GpEcOC
	 TnjRcwdNRyCMuFTe+sIAPg8eB0KnuCv48jtUipsdmPTG1NPasq1PH4HjltWy9X3BDbppr
	 m7uJmHIJjipEGjBbgmuUusUHVnkuYvI5gVY6KtL0PaERrJfnvlq546fjCtwpRQ/fSaA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789497927;
	bh=C99cZNU2yXVXNp4P5evkvQnMApiZN5Vrl+rHRNFtFTw=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=r53RtKvhHrsAqxaaTkyw/FoJj9pOOebSS2nnOPdRKDqtgOX6EVZFJz1NOhWevrlHq
	 Huv07jGx4JPQcFTXIwl3PMYmj9RA6ByKpY0Qu54/yO84qYwyrD6O3jvHmtxTMihiyl
	 Iq0qiSMvEaoY18wF+OTsCHXuP/kZ+ISzfCXMzN+JccZ6J+xyX2x8yQx+UM6iA+OGAf
	 IegxWzsSW07hdo4AsWLgcB6+9+sJ7zXd80IqczIPzoQqp+QPoO22cEqYRLUdYigt5B
	 ldApe4tAEqObDJhZCPIU4iI4Q1UKrPMRJQO3kage5hUg1iFnYJyIVquVUoc8/L4d0h
	 4uZsIOhkC5kzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C73A84033B;
	Tue, 15 Sep 2026 18:45:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B79D9EB
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 18:45:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ACBB78098A
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 18:45:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id af2IepQdelCs for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 18:45:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E1F9180A58
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789497926;
 b=kjbsCBc6ATuPK3P242Qx+2FtxT5yqMEDyh1exOb+bOriIZ6HNitVo2z6QYST9m1yr7NH
 ofEfPHoUrklUvCMDGvIR/V6ZAois9jn4OKVxT4htcWLOvxIndT5flXSmySf0XWWca/vpn
 cGBQpcZseTLScXjy7wCNByCzY3ATwliLB1ri3ipjtKYdNlUJY6m0VbxceCo1Y9OIIYFmf
 ujOAo56wVXtE5NBmjMfvmXgQemNMPvAJJoyBpYe4Nwjjoz1w+8jl2yy+uDfunv+08/9jC
 izJtXrGo+zKPB4LBsbi8zsEdrQlnDReP6+PD0QWl6H0Dei+1wKn28KnU4m9lIWdD+aQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789497926;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
 bh=C99cZNU2yXVXNp4P5evkvQnMApiZN5Vrl+rHRNFtFTw=;
 b=OR/bsv12rgNoiniGSDu1UPeGgNvppkxUnGmyKqNT8QrQJQmJJjecc6o4I+ftZgL3WqD0
 zE0D6u0Wm/a5PaT5vYyso4rHaKdw6FQYUqmoSYBGhYmybElyk+e/bjCDTwzGF+uzLlH+C
 uRA2YFPmrdPZAThsYGb+zWwbPxLI0AXzsbEdKkMQvx8rx/NGM6rZPf6vsB4PQ6wwL124E
 8u6rZ0GdFk3eywpUb/Jx2s/jfdP8kAAMR4w6ttRKt48bP4pHGiAmwIcoeBwg73QLB3lY/
 o+qMFYgAxzUQv8oOAxq/GkkU9AOjsWi1lsyTphxtNoyjZEZtR49F2WT2mNNgdEpZAYw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=r0+aN51c; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=r0+aN51c
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp1.osuosl.org (Postfix) with ESMTP id E1F9180A58
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 18:45:24 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1251)
 id 35EE220B7169; Tue, 15 Sep 2026 11:44:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 35EE220B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1789497880;
 bh=C99cZNU2yXVXNp4P5evkvQnMApiZN5Vrl+rHRNFtFTw=;
 h=Date:From:To:Cc:Subject:From;
 b=r0+aN51cQtu5NplVhZiSHSm+/v7qtoCSJcW5BIJl2THjhvQfAu9yyztAWenj7F/tY
 fID6PFpuXQPXpzqQMRpzKCTe1NtOOlbKRLJbVrqANvHNtVldfMnkhwaT2klDi2INmm
 3SkHSjlfIPCbKWrvl8LkOC5yxTGecdkftwBkdl3Y=
Date: Tue, 15 Sep 2026 11:44:40 -0700
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org;, jerome.forissier@arm.com;,
 ankluemk@microsoft.com
Subject: Re: [PATCH 3/4] net: tftp: use bounded string compare for OACK
Message-ID: <aqmSGDU2o0OawMEc@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

option parsing 
Reply-To: 
Bcc: 
Subject: Re: [PATCH 3/4] net: tftp: use bounded string compare for OACK
 option parsing
Reply-To: 
In-Reply-To: <20260910192538.GO1764417@bill-the-cat>

On Thu, Sep 10, 2026 at 01:25:38PM -0600, Tom Rini wrote:
> On Wed, Sep 09, 2026 at 12:20:15PM -0700, Sriram Sriram wrote:
> 
> > From: Drew Kluemke <ankluemk@microsoft.com>
> > 
> > The TFTP OACK handler matches option names in the received packet with
> > strcasecmp(), which scans until a NUL byte. A malformed or truncated
> > OACK packet may not contain a NUL within the received length, causing
> > an out-of-bounds read past the packet buffer.
> > 
> > Replace each strcasecmp() with a strncasecmp() bounded to the option
> > name length plus an explicit check that the name is NUL-terminated at
> > the expected position. For the "windowsize" option, whose name and
> > value extend beyond the loop's "i + 8 < len" guard, add an explicit
> > "i + 11 < len" bound before the comparison.
> > 
> > Signed-off-by: Drew Kluemke <ankluemk@microsoft.com>
> > Signed-off-by: Sriram Sriram <sriramsriram@linux.microsoft.com>
> > ---
> >  net/tftp.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)

> Does the spec/RFC ensure that we're being given a NULL terminated
> string here? It certainly makes sense to be using strncasecmp here,
> but since we're a size constrained bootloader, we do need to find the
> right balance between defense-in-depth and potential exposure.

Yes.  RFC 2347 defines the OACK as

  +-------+---~~---+---+---~~---+---+---~~---+---+---~~---+---+
  |  opc  |  opt1  | 0 | value1 | 0 |  optN  | 0 | valueN | 0 |
  +-------+---~~---+---+---~~---+---+---~~---+---+---~~---+---+

so every option name and value is a NUL terminated netascii string, and
the last byte of a well-formed OACK is always a NUL.  What we do not
have is any guarantee that the packet on the wire is well-formed --
nothing in tftp_handler() checks that before the strcasecmp()s run.

On exposure: it is real but small.  strcasecmp() bails at the first
mismatching byte, so we only read past the packet when it ends part-way
through something that matches an option name, and the over-read is
then at most strlen("windowsize") + 1 == 11 bytes.  Those bytes are
normally stale data in the same 1536 byte net_rx_packets[] buffer (the
receive buffers are one contiguous pool, net_rx_packets[i] =
net_tx_packet + (i + 1) * PKTSIZE_ALIGN), so we only leave the
allocation for a near-MTU OACK landing in the last rx buffer.

The nastier case is the dectoul() right after a match: if the name and
its NUL end exactly at the end of the packet, dectoul() starts past the
end and runs until it hits a non-digit byte.  v1 of this patch does not
address that at all.

So I think the balance you are asking about argues for a smaller patch
than the one I sent.  Since the RFC guarantees the trailing NUL, we can
check for it once instead of bounding four comparisons:

	case TFTP_OACK:
		/*
		 * RFC 2347 requires every option name and value to be
		 * NUL terminated, so a well-formed OACK always ends in
		 * a NUL.  Verifying that once keeps the option parsing
		 * below in bounds.
		 */
		if (!len || pkt[len - 1] != '\0')
			return;

That leaves the existing strcasecmp()/dectoul() code untouched, covers
the dectoul() calls as well as the name comparisons, and is cheaper.
net/tftp.o .text on am335x_evm_defconfig (arm-linux-gnueabi-, with
CONFIG_TFTP_TSIZE=y and CONFIG_TFTP_WINDOWSIZE=1):

  3222  unpatched
  3246  v1, strncasecmp       (+24)
  3238  trailing NUL check    (+16)

The one behaviour change is that a non-conforming OACK is dropped
rather than half parsed, so we fall back to the retry path instead of
ACKing with whatever the loop happened to pick up.

I will send that as v2 unless you would rather not spend the 16 bytes
at all, in which case I will drop this patch -- the other three in the
series are independent of it.

Thanks,
Sriram

