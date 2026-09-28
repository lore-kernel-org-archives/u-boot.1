Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A65CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 22:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC96F605ED;
	Mon, 28 Sep 2026 22:13:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3xwf-11kMFVX; Mon, 28 Sep 2026 22:13:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2D23D60607
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790633639;
	b=WxCekvrK6CP995ntmy8xZ8izT+UyN3cyLGKpstQGtrTajnpzpTgQkT20m4RP+ZuYBD6T
	 mbxYTVrk+xm/IVepmRoxLS/82qyzJ5g0aDSoRenztPvko27dvRpUE8t5zvzvo8Pb3HDjj
	 40wieKoIcqD5NL6zYsy9OlszY/0q96UNjxAHGwr7BcdYhtCvToBTVBO9JZa1Hy/1WZXy5
	 BhCCPC2btv1RmSNlXI9zgNXjW/Tzg8W2/XBGI7In1qo3TgYMBlixlFKuLrBftoYP8746y
	 5oIjBOHHoVycGDarWnWF/BQvDnyRrMFziSaFZLke1havKT0n8K/6H1LlZS9+Hah9rzg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790633639;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ehx5nGpbth3lBDuVHM4d1WbirZ/sAiZNT3QLBkLuTGU=;
	b=SgbJCDnYxYYutyPlNS2uRZ3lMcetPCbSSv02IK4MerwElYbmVlvjoEMqdwAIEF7crScZ
	 sJ69ukEIA5i0/+ovKEKY6ATHP2iVRILjrQNjj1BvDEivipMdR+26h0Z3JwGC9Lbhtwwtg
	 cCNmbrE3nUIiOt6vvH+LzO8iF6xUB4WyEYMg5ztRH6+acsInlOZ55AMqDS+4e/0EZPbH7
	 bKffG9ReNdSYxDveq/YzescbYmneR9MXnnlZ7zJN9ipqXOge2ndzBWCtUkLyDNt7H61T0
	 fA1hHpy2klVABkz8pffBgLUUaN6+uaHVSMZWQqQDK12JEaC+fcQmmZulszT6goA9ldg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=VsSQduJP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790633639;
	bh=ehx5nGpbth3lBDuVHM4d1WbirZ/sAiZNT3QLBkLuTGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UOadX1FndE1j0qPhE8yoyYobiNqDL/WKYXc9RUwllH8kjOc2na1a7HtMYbcWYyrUM
	 fSL528HYyNaLVq+c0033gnGMyrnC+8PuAfQuYY/jE7s2kipjbpetYBw3i0nSSFTvih
	 yztH/1PoXHv7FyqIBoI2OL9qd2nJN3hW4DvusN7FjntdsQWT6DUVkj5HlY/4AW7Enj
	 Dl1+B5fzBhEsj9BqosQtbL0tziBa/K7hbluiE9uWowidLEImTozxrzzWNmWk27pKYf
	 DgGXIIhTx/G2dqNMLwqxB7/e6lJFSoB/PbZdLMY23b+RqvfH6Um8PFMuiN8Y1dorAX
	 jEeMd854oOb7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D23D60607;
	Mon, 28 Sep 2026 22:13:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 32482335
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:13:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1831560607
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:13:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YkTJNiw0gySB for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 22:13:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7AFA2605ED
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790633637;
 b=reN/T2kowZM5XE/85vwvt1YTW++F9epDrDSxZr4XmmS4CRn6NSPx9cBgkbQ90Z0+KPd7
 mKodZyd4bbIdSRpjC6LcQR7HHpG3sk4V7yrnIgPjgHN/NIvrLQlJ1WAA2vQmtetBy4uQc
 dfPaB4LUJPfhikfbMOttpU2gxCioPodC997pv1cS32/mu6GaZc/DFHrcNNOuk08CE/+8S
 YYAKA+2GHekIwQcPfmO0mzWNRaVbjuRVa9uQ0nK8MwCaEKs5dD5iWLuv/LXYB+Le9sp/U
 gV4R4nef88wMf2u0t8x1EJwvPJGlnkTXWhGQGebh1GSvNgibT8nivHf696PYu7y8TgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790633637;
 h=Received-SPF:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=ehx5nGpbth3lBDuVHM4d1WbirZ/sAiZNT3QLBkLuTGU=;
 b=iQ6xjy2nhZakKVVVN+ZhO+VqRHbtyXEEiu5oIPIQlv8VsZ3aRuuxYnUdyYDjrcgr0DES
 bXzWCtg36BC+CsFRmwAk013xLDYAmFVAWB70wxD5bQVk8gr5MPCI1RgR3mANlrKziFn3C
 qdivUu4YtgjmYQCPGBRXXDTmbjQrIyEnuGtPxHvIfYx0uw0ZlXZLwEeLjRi5KHt/iz/q8
 eaz2W91ssjRcsocinlh434WQCmPFDMLf9M53A8RELj7RcJyHyUm66vjEh5aHmYgShIW3V
 HXdlIJaiLOOWgldgfowNhTx8IA1SJ7iW4V2ODRQoeghDUDrclRgJyKrZhNCDMxQjbJw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linux.microsoft.com; 
 dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=VsSQduJP; 
 arc=none smtp.remote-ip=13.77.154.182
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=sriramsriram@linux.microsoft.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=VsSQduJP
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7AFA2605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 22:13:56 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1251)
 id 2271620B716A; Mon, 28 Sep 2026 15:13:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2271620B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1790633584;
 bh=ehx5nGpbth3lBDuVHM4d1WbirZ/sAiZNT3QLBkLuTGU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VsSQduJP2blwoL1ENNL0XZeFS9xq4rpaoZtj6071S8jphLsIfK4c3Yfv0fC4f93EW
 5nTYkzttyZ49a7HSssKaXY+ecT+OOx46Nj7/4Qp0j3/eNNJSXqvt9P66e7uqN7Klrm
 DGGGM4435uhJ4q7Eq+dOyTXaVdtsXlddLBPz5gP8=
Date: Mon, 28 Sep 2026 15:13:04 -0700
From: Sriram Sriram <sriramsriram@linux.microsoft.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <monstr@monstr.eu>,
 Maarten Brock <Maarten.Brock@sttls.nl>, Tom Rini <trini@konsulko.com>,
 Drew Kluemke <ankluemk@microsoft.com>
Subject: Re: [PATCH v2 0/2] board: xilinx: board_name_decode() allocation fix
 and weak ft_board_setup()
Message-ID: <arrmcBhrDKJgKNE3@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260909192047.217421-1-sriramsriram@linux.microsoft.com>
 <20260916173611.29425-1-sriramsriram@linux.microsoft.com>
 <84191007-befe-403f-b31f-f857160287bd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84191007-befe-403f-b31f-f857160287bd@amd.com>
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

On Fri, Sep 25, 2026 at 03:51:57PM +0200, Michal Simek wrote:
> 
> 
> On 9/16/26 19:36, Sriram Sriram wrote:
> > v1 1/2 ("board: xilinx: Use strlcat() in board_name_decode()") is dropped
> > from this series in favour of Pranav Tilak's patch, which fixes the same
> > heap overflow without the extra strlen().
> > 
> > It is replaced here by a separate defect in the same function that
> > neither version of the strlcat() conversion touches: the calloc() result
> > is never checked (the test is on board_info), and that early return is
> > the one exit path that does not free board_local_name.
> > 
> > 2/2 is unchanged from v1 and is resent per Michal's request.
> > 
> > Sriram Sriram (2):
> >    board: xilinx: Check calloc() result in board_name_decode()
> >    board: xilinx: Make ft_board_setup() weak
> > 
> >   board/xilinx/common/board.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> 
> Applied.
> M

Great! Thank you.

Regards,
Sriram

