Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA49C982ED
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 00:20:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26E5740800;
	Tue, 22 Sep 2026 00:20:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QXbUEY6pnzU1; Tue, 22 Sep 2026 00:20:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 13B4D407C5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790036443;
	b=suMrtM4qkP78mz+xGgDoZgYhjZyJv4w3HgDEBOhMf8hzcxnDvxhi6tX2KYLFXDDa4JJb
	 HWWjkYhRb589tSkMJtfYvzZdewOIwjvUmOvJwV9zjp9mHM90KEok73LusTT9IC/GTzbmS
	 B4pU63X7wjwGu/aO8w1atap7g8Cya4UtBrDRyMRd/D9r3is/cC7qIK1P3NmyMg8Nmu93h
	 je3wkwWXUGvuDyHruG4E6obFpl35NCamwpwc2HoS5/xeFf5QppP9ZCtaOwj53drvRz4kr
	 Vz+cO0/SrKbhKxNZF5BciRQFsoNDxdvZn1r+l3A+42W1fkKe+L8r3IU4rbm9U2MporQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790036443;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eA2/SY8OptitKDqIyNYbL8PbcwBV/RuMtPPTca5YiWM=;
	b=LffYyJflLXSW32BG4yGi4E7qXOYJiTsR0FWOspyZmaF2v+mPUEJfgIWLCeFwLaJX4XW6
	 VCHO6CtIJkzRmYqWbhKQ55AZM0PhyGJMzR/ipuf+BlJQ6AN5oCL3uDZb+fnWwdtHN+tGF
	 b5GsTXiroTvpd+ErLaYjB8kWS21w3sl/c8y36sc61f6GTy63ASMX1Fbv6kGDG/KjstFr5
	 bEHYZCZTfAcGD5ljPCLd4YLgg1O7WLoNLHXEXd8jQ4V8923TpZ7KCG63GXFptaaTeaD2V
	 b/R+o8PtemBW4MoM7MSNDkqxUsC/Aqevy0S9vqcDZPo8AJV0vOgyafNBxi09376vcCQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=aA2E1bDN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790036443;
	bh=eA2/SY8OptitKDqIyNYbL8PbcwBV/RuMtPPTca5YiWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E6iQ0ZqfDrly6NL9UZBSKXL8ZlVBZTEdqE/zCLGecZx68uFAFo/kwrGqFFVlxKkGI
	 phYjX59ec+B3fRMvmi7gjT4GT7D0esW0E9EF0+aHFAeC8BBgQLu/n63LYL7vfzUswp
	 YPRnrOiqXfwqNnb3TIBhAVkZyawWOLSfpV3/enaT6be64lmp4PotCS12ySyp20HFop
	 p/H92INuPYLdlSxm9EhsvRCI1QLDwHE3vGZoDmzy0i9u1frOUQZvCXOxm/ovZiJb1L
	 NsS7xyOP902oBSqj2ooxd/2D8OIJXN8CZr6mzbNwssxthyAJ4/PIP4y4uN/kROpnOv
	 NhUh2pEbtaKTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13B4D407C5;
	Tue, 22 Sep 2026 00:20:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 53940B02
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 00:20:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 39E14407E7
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 00:20:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yz-mvrBNGltL for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 00:20:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D1F25407C5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790036440;
 b=aGaM2aZoR2YRg1319slMSUtsfY6/LihTAimMlxUGPNKdkq3us/HBPMONu3930KzSRutq
 dww3hjUBGvJnIVNEEePEXPKQSlfJ73kupqjdrXiL+aQGsjI1JogBhkILZ4erFy7JVjF5c
 aK2pyJjN9iy+JpGPstlO2NhTH69fBUYIecTCrGkMxxNio/NKA3LyhwJliE+ri5RbCMj5Q
 Pfb9ggR82AvO0822vzviTnDgCYM+VI2SPaMOu66vorrLkhIH0xFCdBMzDRVErGGDixq1v
 Kf8XiG439ZOXbQOjEl8/QUVofE5e6jTTP7vGbjOOe3zrYxhFWRI99dICqfGv5GZsplg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790036440;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=eA2/SY8OptitKDqIyNYbL8PbcwBV/RuMtPPTca5YiWM=;
 b=sNsIaDe8qwSieJkVlNETqjx92UhCFITwp5PAkPboaENLibD37TDJCXMtBuFiTe8W1T6A
 ev6KadJLUpwgj6q+dBp/XQ/dygH9nB65r6r9PFWAqlpBUQ8eibFB9C+gn23g2oE6FkPp2
 7qfC2Bv5MURj+6ISuxxLxNdxlHFQR7kvqEHPZoGvlIvdqodVskaLh+tRapaO3OFImYMEm
 nR0dPuEe5nuXGou1242kNnIEmmKLdB5hDziyqSAQ9fVKgDjWnMoDLjNhlqF3Hc0q8bkaX
 RfeBzgvpPzmTDujJKwB8bX5irJYY98FHT1M6zvgvXR81q0ycQaiyLYX/p7jCkamTPQw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=aA2E1bDN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.12;
 helo=sender6-op-o12.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=aA2E1bDN
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com
 [165.173.180.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D1F25407C5
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 00:20:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790036436; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iGtDCkNiyi7OlpoNx7jc8IwF3EdAC2Wu1gUogKeRjgZS3WGzyykE43me3R3Q0Z3XT//IDdScw7SZ2Np6/w7B1WFzc44lVNQjdoWzltOIG03gFw79NRDIPJ43wUCL3aGXCOfNHqHfJMctdapctADvq41WVnMXp10uamorYIasba4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790036436;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=eA2/SY8OptitKDqIyNYbL8PbcwBV/RuMtPPTca5YiWM=; 
 b=THPtwrX4xeRwfisu69uooi3khjsGWW9xVALoKg44zVuBJnJmhkSHFsEIe48sahZ0Ij0T6W4azf6ovv5ZgVajzyq6ctPE5sU+xL8gATiqQbrNdmkjIVgiwQbnWmgouuAJ+Y/UV74P0b4Qx5eUzx5kgBJohGrtftRmW6n2bzBsmbc=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790036436; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=eA2/SY8OptitKDqIyNYbL8PbcwBV/RuMtPPTca5YiWM=;
 b=aA2E1bDNYaqmU9YmHYqOXcZeLwW/vEh3PxZHpcWNOXlcs3A1Zy/BgLkMxF11blE2
 XP+AF4lHpj76uFZ2/eiapq1SvWzN6VBf8D+KvsWPg3VnmtHl4ONtIck2ZXbvGQWXVS0
 R+lV1TsLIg2MGiSrFBPbtfoLXRc+brYbHXSCqeXc=
Received: by smtp.zohomail.com with SMTPS id 1790036436286407.45613913965803; 
 Mon, 21 Sep 2026 17:20:36 -0700 (PDT)
Date: Tue, 22 Sep 2026 00:20:29 +0000
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: u-boot-custodians@lists.u-boot-project.org,
 u-boot-board-maintainers@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Subject: Re: [ANN] U-Boot v2026.10-rc5 released
Message-ID: <arHJzfAsy1mK8RDC@pie>
References: <20260921221325.GF858934@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921221325.GF858934@bill-the-cat>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/290.25.6
X-ZohoMailClient: External
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

On Mon, Sep 21, 2026 at 04:13:25PM -0600, Tom Rini wrote:
> Hey all,
> 
> Once again  it's release day and I have tagged and pushed things out.
> 
> Things seem to be working well on our new infrastructure but if anyone
> has found issues please bring them up.

I've found a nit on the lore.kernel.org/u-boot/ page, though it archives
the latest mails, it's titled as "u-boot.lists.denx.de archive" lol.

> I believe overall things are looking on track for the v2026.10 release
> itself, and things are moving along in the next branch at the moment.
> 
> So, the git tag has been pushed to
> https://git.u-boot-project.org/u-boot/u-boot and the release itself is
> also under https://git.u-boot-project.org/u-boot/u-boot/-/releases/
> 
> We're continuing with a community meeting following the release and the
> calendar link is
> https://calendar.google.com/calendar/event?action=TEMPLATE&tmeid=Z2IwbHR2NjZhMzZkOThqNHJoc2sxZG04MzJfMjAyNjA3MjhUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwNmE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com&scp=ALL
> and once again this is the same time as the previous meeting. The
> meeting details itself are:
> https://meet.google.com/jwj-pqka-bnj
> September 22nd, 2026. 9am (GMT -06:00)
> 
> To join by phone:
> Or dial: (US) +1 929-277-5781 PIN: 115 674 167
> More phone numbers: https://tel.meet/jwj-pqka-bnj?pin=2145803234090
> 
> In terms of a rough changelog:
> - Platform updates for Renesas R-Carand STM32
> - Fixes in our NVMe, PCI, networking and DFU subsystems / drivers.
> - A few other assorted bug fixes / hardenings.
> 
> We should have one final rc release in two week, prior to the final
> release on 05 October 2026.

And I think rc5 is expected to be the final rc release?

> Thanks all!
> 
> -- 
> Tom

Thanks,
Yao Zi
