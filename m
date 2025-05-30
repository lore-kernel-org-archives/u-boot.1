Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19782C5B549
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 14:05:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6917382B97;
	Fri, 30 May 2025 16:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nrx7Ea2y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17F1182BAA; Fri, 30 May 2025 16:05:55 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36F4182B70
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 16:05:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2e8f394bb75so1255907fac.3
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748613951; x=1749218751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0x+rJ/nseqkLRH9+xy1Zh2R0iwDzu+O4H1ioa9YC6Fo=;
 b=Nrx7Ea2yvCwxHwpO7nT3aQRpzANOiDg9KzF5beCv0D/8VHj6kx5FMtsfq3+Txvliwb
 f+5j7Q/6tWirCWGOlAA42SAu9W5OKUBttGSCPvkXnbW4ZNyfJ0UZwpdDKktguzysO4gc
 q/AegQJT1cShtbbd4tQGhvDRRyKYItRMNrJOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748613951; x=1749218751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0x+rJ/nseqkLRH9+xy1Zh2R0iwDzu+O4H1ioa9YC6Fo=;
 b=rXLuMyIfCunDp0ejUz/REiKDkBI737cMuXy8n0P+c9LgnjNKc6LvzA84exeZjecye3
 ZwoxVc3SS5j01SdLSqKn9YCmiydyTQzal/wugAz9ZGwW79Jv62ORD2YuIiTKj+OAVElK
 RbM9qvLhXdjQXuAS66izRoKB9SSSI7b9g1SoBmVjIXO4DGF2xrsXK08IxkUf+0yBQSik
 l07mTlWJOuXmpZYHSnLxKiDMBnzkaXwwigQ+L/PGRCeIr947pL57HfP4YyZ3ckDlRrSC
 JlKOpIyRBPpGV3dn/axfK19ouht7EpyYpKzF4YwuuDbBKkTuBo/0Abjc4WKKFihgH32q
 Urvg==
X-Gm-Message-State: AOJu0YwCEaV5DwLx0+EHVmDxMLP0i+CslREQ/ROdfk5GOrjZVjLvnk9K
 o+8OHcd4ZTDWJ2o5Qzychna2dXFfHbWZtmcWMWY/ed1bFq2w88ALbs8nm5Pdck2O+GjMEco9eIJ
 TcWTHezg=
X-Gm-Gg: ASbGncsNAuw/Qel/2d0HUCJttls7TXPXCF/hlVE2D4/Ygp8X+qPa8Fj/GN6Q+L4LR9Q
 lbA1pRzj+0fNylhAh9B+FYfOpuFEQT4k0PpcKzc+23/1DENGH4NKG0YT6YoKndFHRfW0vSVutjY
 OWRNcNX2q4k6pnURTwqxwMem4NSFO1CQVimF4ALL6bPJbhGsZOojhiXO1dDItkeckjqWLyvwafi
 PtvgX/447Ng+lXYaD1+o7IDVOSNoyNlXpgmIIiQbLVp0KvC4p/ZvJ9aBWLJHTBkr1oYEgQvnnL+
 mE6NvJOLrpjnWR1kkyK65cQUfZeLZfJejs39ql7xlB8gkPm5JUjjL0/4XJ2ZqoGMghrwsrMD4IT
 gHKN4/UF4+ji87kI=
X-Google-Smtp-Source: AGHT+IFiqo37ENtDtx/KTUxUPWJi/C76peGhikzz5+37aQgnRJ4jyIlbgGT0h30FrcecCS8CjZWygw==
X-Received: by 2002:a05:6870:15cd:b0:2d8:5015:1a8f with SMTP id
 586e51a60fabf-2e921184271mr1693879fac.7.1748613950599; 
 Fri, 30 May 2025 07:05:50 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e906b811easm675416fac.35.2025.05.30.07.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 07:05:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Yao Zi <ziyao@disroot.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] scripts/spelling.txt: Sync script with kernel v6.15
Date: Fri, 30 May 2025 08:05:48 -0600
Message-ID: <20250530140548.4030025-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Keep spelling.txt in sync with the version from kernel v6.15.

Reported-by: Yao Zi <ziyao@disroot.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>

Heinrich, adding 'volatge' here makes sense, but also makes sense in the
kernel I believe (it's wrong in 4 places as of v6.15, and at least once
in a commit message), can you please upstream that? Thanks.
---
 scripts/spelling.txt | 193 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 191 insertions(+), 2 deletions(-)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index aec616b1d3bf..50791c71f45d 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -23,8 +23,10 @@ absoulte||absolute
 acccess||access
 acceess||access
 accelaration||acceleration
+accelearion||acceleration
 acceleratoin||acceleration
 accelleration||acceleration
+accelrometer||accelerometer
 accesing||accessing
 accesnt||accent
 accessable||accessible
@@ -58,11 +60,13 @@ acording||according
 activete||activate
 actived||activated
 actualy||actually
+actvie||active
 acumulating||accumulating
 acumulative||accumulative
 acumulator||accumulator
 acutally||actually
 adapater||adapter
+adderted||asserted
 addional||additional
 additionaly||additionally
 additonal||additional
@@ -120,6 +124,7 @@ alue||value
 ambigious||ambiguous
 ambigous||ambiguous
 amoung||among
+amount of times||number of times
 amout||amount
 amplifer||amplifier
 amplifyer||amplifier
@@ -133,8 +138,10 @@ anniversery||anniversary
 annoucement||announcement
 anomolies||anomalies
 anomoly||anomaly
+anonynous||anonymous
 anway||anyway
 aplication||application
+apeared||appeared
 appearence||appearance
 applicaion||application
 appliction||application
@@ -149,8 +156,10 @@ apropriate||appropriate
 aquainted||acquainted
 aquired||acquired
 aquisition||acquisition
+aquires||acquires
 arbitary||arbitrary
 architechture||architecture
+archtecture||architecture
 arguement||argument
 arguements||arguments
 arithmatic||arithmetic
@@ -169,16 +178,22 @@ assigment||assignment
 assigments||assignments
 assistent||assistant
 assocaited||associated
+assocated||associated
 assocating||associating
 assocation||association
+assocative||associative
 associcated||associated
 assotiated||associated
 asssert||assert
 assum||assume
 assumtpion||assumption
+asume||assume
 asuming||assuming
 asycronous||asynchronous
+asychronous||asynchronous
 asynchnous||asynchronous
+asynchrnous||asynchronous
+asynchronus||asynchronous
 asynchromous||asynchronous
 asymetric||asymmetric
 asymmeric||asymmetric
@@ -207,6 +222,7 @@ autonymous||autonomous
 auxillary||auxiliary
 auxilliary||auxiliary
 avaiable||available
+avaialable||available
 avaible||available
 availabe||available
 availabled||available
@@ -230,6 +246,7 @@ baloons||balloons
 bandwith||bandwidth
 banlance||balance
 batery||battery
+battey||battery
 beacuse||because
 becasue||because
 becomming||becoming
@@ -241,6 +258,7 @@ beter||better
 betweeen||between
 bianries||binaries
 bitmast||bitmask
+bitwiedh||bitwidth
 boardcast||broadcast
 borad||board
 boundry||boundary
@@ -249,14 +267,18 @@ brigde||bridge
 broadcase||broadcast
 broadcat||broadcast
 bufer||buffer
+bufferred||buffered
+bufferur||buffer
 bufufer||buffer
 cacluated||calculated
 caculate||calculate
 caculation||calculation
 cadidate||candidate
 cahces||caches
+calcluate||calculate
 calender||calendar
 calescing||coalescing
+calibraiton||calibration
 calle||called
 callibration||calibration
 callled||called
@@ -265,7 +287,12 @@ calucate||calculate
 calulate||calculate
 cancelation||cancellation
 cancle||cancel
+cant||can't
+cant'||can't
 canot||cannot
+cann't||can't
+cannnot||cannot
+capabiity||capability
 capabilites||capabilities
 capabilties||capabilities
 capabilty||capability
@@ -273,9 +300,11 @@ capabitilies||capabilities
 capablity||capability
 capatibilities||capabilities
 capapbilities||capabilities
+captuer||capture
 caputure||capture
 carefuly||carefully
 cariage||carriage
+casued||caused
 catagory||category
 cehck||check
 challange||challenge
@@ -302,12 +331,14 @@ chiled||child
 chked||checked
 chnage||change
 chnages||changes
+chnange||change
 chnnel||channel
 choosen||chosen
 chouse||chose
 circumvernt||circumvent
 claread||cleared
 clared||cleared
+clearify||clarify
 closeing||closing
 clustred||clustered
 cnfiguration||configuration
@@ -323,11 +354,13 @@ comminucation||communication
 commited||committed
 commiting||committing
 committ||commit
+commmand||command
 commnunication||communication
 commoditiy||commodity
 comsume||consume
 comsumer||consumer
 comsuming||consuming
+comaptible||compatible
 compability||compatibility
 compaibility||compatibility
 comparsion||comparison
@@ -348,15 +381,20 @@ compoment||component
 comppatible||compatible
 compres||compress
 compresion||compression
+compresser||compressor
 comression||compression
+comsumed||consumed
 comunicate||communicate
 comunication||communication
 conbination||combination
+concurent||concurrent
 conditionaly||conditionally
 conditon||condition
 condtion||condition
+condtional||conditional
 conected||connected
 conector||connector
+configed||configured
 configration||configuration
 configred||configured
 configuartion||configuration
@@ -366,8 +404,10 @@ configuratoin||configuration
 configuraton||configuration
 configuretion||configuration
 configutation||configuration
+congiuration||configuration
 conider||consider
 conjuction||conjunction
+connction||connection
 connecetd||connected
 connectinos||connections
 connetor||connector
@@ -375,6 +415,8 @@ connnection||connection
 connnections||connections
 consistancy||consistency
 consistant||consistent
+consits||consists
+constructred||constructed
 containes||contains
 containts||contains
 contaisn||contains
@@ -385,6 +427,7 @@ continious||continuous
 continous||continuous
 continously||continuously
 continueing||continuing
+contiuous||continuous
 contraints||constraints
 contruct||construct
 contol||control
@@ -407,8 +450,11 @@ cotrol||control
 cound||could
 couter||counter
 coutner||counter
+creationg||creating
 cryptocraphic||cryptographic
+cummulative||cumulative
 cunter||counter
+curent||current
 curently||currently
 cylic||cyclic
 dafault||default
@@ -420,7 +466,9 @@ decendant||descendant
 decendants||descendants
 decompres||decompress
 decsribed||described
+decrese||decrease
 decription||description
+detault||default
 dectected||detected
 defailt||default
 deferal||deferral
@@ -429,6 +477,7 @@ defferred||deferred
 definate||definite
 definately||definitely
 definiation||definition
+definiton||definition
 defintion||definition
 defintions||definitions
 defualt||default
@@ -442,6 +491,8 @@ delare||declare
 delares||declares
 delaring||declaring
 delemiter||delimiter
+deley||delay
+delibrately||deliberately
 delievered||delivered
 demodualtor||demodulator
 demension||dimension
@@ -454,6 +505,7 @@ depreacte||deprecate
 desactivate||deactivate
 desciptor||descriptor
 desciptors||descriptors
+descritpor||descriptor
 descripto||descriptor
 descripton||description
 descrition||description
@@ -470,7 +522,9 @@ destorys||destroys
 destroied||destroyed
 detabase||database
 deteced||detected
+detecion||detection
 detectt||detect
+detroyed||destroyed
 develope||develop
 developement||development
 developped||developed
@@ -490,6 +544,7 @@ diferent||different
 differrence||difference
 diffrent||different
 differenciate||differentiate
+diffreential||differential
 diffrentiate||differentiate
 difinition||definition
 digial||digital
@@ -497,16 +552,20 @@ dimention||dimension
 dimesions||dimensions
 diconnected||disconnected
 disabed||disabled
+disasembler||disassembler
 disble||disable
 disgest||digest
 disired||desired
 dispalying||displaying
+dissable||disable
+dissapeared||disappeared
 diplay||display
 directon||direction
 direcly||directly
 direectly||directly
 diregard||disregard
 disassocation||disassociation
+disassocative||disassociative
 disapear||disappear
 disapeared||disappeared
 disappared||disappeared
@@ -524,6 +583,7 @@ dissconect||disconnect
 distiction||distinction
 divisable||divisible
 divsiors||divisors
+dsiabled||disabled
 docuentation||documentation
 documantation||documentation
 documentaion||documentation
@@ -554,6 +614,7 @@ eigth||eight
 elementry||elementary
 eletronic||electronic
 embeded||embedded
+emtpy||empty
 enabledi||enabled
 enbale||enable
 enble||enable
@@ -561,6 +622,7 @@ enchanced||enhanced
 encorporating||incorporating
 encrupted||encrypted
 encrypiton||encryption
+encryped||encrypted
 encryptio||encryption
 endianess||endianness
 enpoint||endpoint
@@ -590,11 +652,14 @@ etsbalishment||establishment
 evalute||evaluate
 evalutes||evaluates
 evalution||evaluation
+evaulated||evaluated
 excecutable||executable
+excceed||exceed
 exceded||exceeded
 exceds||exceeds
 exceeed||exceed
 excellant||excellent
+exchnage||exchange
 execeeded||exceeded
 execeeds||exceeds
 exeed||exceed
@@ -603,17 +668,23 @@ exeuction||execution
 existance||existence
 existant||existent
 exixt||exist
+exsits||exists
 exlcude||exclude
+exlcuding||excluding
 exlcusive||exclusive
+exlusive||exclusive
+exlicitly||explicitly
 exmaple||example
 expecially||especially
 experies||expires
 explicite||explicit
+explicity||explicitly
 explicitely||explicitly
 explict||explicit
 explictely||explicitly
 explictly||explicitly
 expresion||expression
+exprienced||experienced
 exprimental||experimental
 extened||extended
 exteneded||extended
@@ -642,27 +713,32 @@ feauture||feature
 feautures||features
 fetaure||feature
 fetaures||features
+fetcing||fetching
 fileystem||filesystem
 fimrware||firmware
 fimware||firmware
 firmare||firmware
 firmaware||firmware
+firtly||firstly
 firware||firmware
 firwmare||firmware
 finanize||finalize
 findn||find
 finilizes||finalizes
 finsih||finish
+fliter||filter
 flusing||flushing
 folloing||following
 followign||following
 followings||following
 follwing||following
 fonud||found
+forcebly||forcibly
 forseeable||foreseeable
 forse||force
 fortan||fortran
 forwardig||forwarding
+forwared||forwarded
 frambuffer||framebuffer
 framming||framing
 framwork||framework
@@ -670,6 +746,7 @@ frequence||frequency
 frequncy||frequency
 frequancy||frequency
 frome||from
+fronend||frontend
 fucntion||function
 fuction||function
 fuctions||functions
@@ -693,6 +770,8 @@ generiously||generously
 genereate||generate
 genereted||generated
 genric||generic
+gerenal||general
+geting||getting
 globel||global
 grabing||grabbing
 grahical||graphical
@@ -700,6 +779,7 @@ grahpical||graphical
 granularty||granularity
 grapic||graphic
 grranted||granted
+grups||groups
 guage||gauge
 guarenteed||guaranteed
 guarentee||guarantee
@@ -711,21 +791,27 @@ hanled||handled
 happend||happened
 hardare||hardware
 harware||hardware
+hardward||hardware
 havind||having
+heigth||height
 heirarchically||hierarchically
 heirarchy||hierarchy
+heirachy||hierarchy
 helpfull||helpful
 hearbeat||heartbeat
 heterogenous||heterogeneous
 hexdecimal||hexadecimal
 hybernate||hibernate
+hiearchy||hierarchy
 hierachy||hierarchy
 hierarchie||hierarchy
 homogenous||homogeneous
+horizental||horizontal
 howver||however
 hsould||should
 hypervior||hypervisor
 hypter||hyper
+idel||idle
 identidier||identifier
 iligal||illegal
 illigal||illegal
@@ -754,6 +840,7 @@ implmentation||implementation
 implmenting||implementing
 incative||inactive
 incomming||incoming
+incompaitiblity||incompatibility
 incompatabilities||incompatibilities
 incompatable||incompatible
 incompatble||incompatible
@@ -771,6 +858,7 @@ independed||independent
 indiate||indicate
 indicat||indicate
 inexpect||inexpected
+infalte||inflate
 inferface||interface
 infinit||infinite
 infomation||information
@@ -779,6 +867,7 @@ informations||information
 informtion||information
 infromation||information
 ingore||ignore
+inheritence||inheritance
 inital||initial
 initalized||initialized
 initalised||initialized
@@ -789,6 +878,7 @@ initators||initiators
 initialiazation||initialization
 initializationg||initialization
 initializiation||initialization
+initializtion||initialization
 initialze||initialize
 initialzed||initialized
 initialzing||initializing
@@ -805,12 +895,14 @@ instanciate||instantiate
 instanciated||instantiated
 instuments||instruments
 insufficent||insufficient
+intead||instead
 inteface||interface
 integreated||integrated
 integrety||integrity
 integrey||integrity
 intendet||intended
 intented||intended
+interal||internal
 interanl||internal
 interchangable||interchangeable
 interferring||interfering
@@ -822,6 +914,7 @@ interoprability||interoperability
 interuupt||interrupt
 interupt||interrupt
 interupts||interrupts
+interurpt||interrupt
 interrface||interface
 interrrupt||interrupt
 interrup||interrupt
@@ -862,12 +955,14 @@ iteraions||iterations
 iternations||iterations
 itertation||iteration
 itslef||itself
+ivalid||invalid
 jave||java
 jeffies||jiffies
 jumpimng||jumping
 juse||just
 jus||just
 kown||known
+lable||label
 langage||language
 langauage||language
 langauge||language
@@ -916,9 +1011,11 @@ matchs||matches
 mathimatical||mathematical
 mathimatic||mathematic
 mathimatics||mathematics
+maxmium||maximum
 maximium||maximum
 maxium||maximum
 mechamism||mechanism
+mechanim||mechanism
 meetign||meeting
 memeory||memory
 memmber||member
@@ -927,6 +1024,7 @@ memroy||memory
 ment||meant
 mergable||mergeable
 mesage||message
+mesages||messages
 messags||messages
 messgaes||messages
 messsage||message
@@ -935,9 +1033,13 @@ metdata||metadata
 micropone||microphone
 microprocesspr||microprocessor
 migrateable||migratable
+miliseconds||milliseconds
+millenium||millennium
 milliseonds||milliseconds
+minimim||minimum
 minium||minimum
 minimam||minimum
+minimun||minimum
 miniumum||minimum
 minumum||minimum
 misalinged||misaligned
@@ -956,6 +1058,7 @@ mmnemonic||mnemonic
 mnay||many
 modfiy||modify
 modifer||modifier
+modul||module
 modulues||modules
 momery||memory
 memomry||memory
@@ -965,8 +1068,9 @@ monochromo||monochrome
 monocrome||monochrome
 mopdule||module
 mroe||more
-multipler||multiplier
 mulitplied||multiplied
+muliple||multiple
+multipler||multiplier
 multidimensionnal||multidimensional
 multipe||multiple
 multple||multiple
@@ -989,15 +1093,19 @@ negotation||negotiation
 nerver||never
 nescessary||necessary
 nessessary||necessary
+none existent||non-existent
 noticable||noticeable
 notication||notification
 notications||notifications
 notifcations||notifications
 notifed||notified
 notity||notify
+notfify||notify
 nubmer||number
 numebr||number
+numer||number
 numner||number
+nunber||number
 obtaion||obtain
 obusing||abusing
 occassionally||occasionally
@@ -1009,17 +1117,20 @@ occured||occurred
 occurence||occurrence
 occure||occurred
 occuring||occurring
+ocurrence||occurrence
 offser||offset
 offet||offset
 offlaod||offload
 offloded||offloaded
 offseting||offsetting
+oflload||offload
 omited||omitted
 omiting||omitting
 omitt||omit
 ommiting||omitting
 ommitted||omitted
 onself||oneself
+onthe||on the
 ony||only
 openning||opening
 operatione||operation
@@ -1031,12 +1142,14 @@ orientatied||orientated
 orientied||oriented
 orignal||original
 originial||original
+orphanded||orphaned
 otherise||otherwise
 ouput||output
 oustanding||outstanding
 overaall||overall
 overhread||overhead
 overlaping||overlapping
+oveflow||overflow
 overflw||overflow
 overlfow||overflow
 overide||override
@@ -1056,9 +1169,11 @@ pakage||package
 paket||packet
 pallette||palette
 paln||plan
+palne||plane
 paramameters||parameters
 paramaters||parameters
 paramater||parameter
+paramenters||parameters
 parametes||parameters
 parametised||parametrised
 paramter||parameter
@@ -1085,12 +1200,16 @@ perfomring||performing
 periperal||peripheral
 peripherial||peripheral
 permissons||permissions
+permited||permitted
 peroid||period
 persistance||persistence
 persistant||persistent
 phoneticly||phonetically
+pipline||pipeline
+plaform||platform
 plalform||platform
 platfoem||platform
+platfomr||platform
 platfrom||platform
 plattform||platform
 pleaes||please
@@ -1102,9 +1221,11 @@ poiter||pointer
 posible||possible
 positon||position
 possibilites||possibilities
+postion||position
 potocol||protocol
 powerfull||powerful
 pramater||parameter
+preambule||preamble
 preamle||preamble
 preample||preamble
 preapre||prepare
@@ -1113,6 +1234,7 @@ preceeding||preceding
 preceed||precede
 precendence||precedence
 precission||precision
+predicition||prediction
 preemptable||preemptible
 prefered||preferred
 prefferably||preferably
@@ -1126,15 +1248,19 @@ preprare||prepare
 pressre||pressure
 presuambly||presumably
 previosuly||previously
+previsously||previously
 primative||primitive
 princliple||principle
 priorty||priority
+priting||printing
 privilaged||privileged
 privilage||privilege
 priviledge||privilege
+priviledged||privileged
 priviledges||privileges
 privleges||privileges
 probaly||probably
+probabalistic||probabilistic
 procceed||proceed
 proccesors||processors
 procesed||processed
@@ -1154,6 +1280,7 @@ programable||programmable
 programers||programmers
 programm||program
 programms||programs
+progres||progress
 progresss||progress
 prohibitted||prohibited
 prohibitting||prohibiting
@@ -1182,12 +1309,15 @@ purgable||purgeable
 pwoer||power
 queing||queuing
 quering||querying
+querrying||querying
 queus||queues
 randomally||randomly
 raoming||roaming
+readyness||readiness
 reasearcher||researcher
 reasearchers||researchers
 reasearch||research
+recalcualte||recalculate
 receieve||receive
 recepient||recipient
 recevied||received
@@ -1200,8 +1330,10 @@ recieves||receives
 recieving||receiving
 recogniced||recognised
 recognizeable||recognizable
+recompte||recompute
 recommanded||recommended
 recyle||recycle
+redect||reject
 redircet||redirect
 redirectrion||redirection
 redundacy||redundancy
@@ -1209,11 +1341,14 @@ reename||rename
 refcounf||refcount
 refence||reference
 refered||referred
+referencce||reference
 referenace||reference
+refererence||reference
 refering||referring
 refernces||references
 refernnce||reference
 refrence||reference
+regiser||register
 registed||registered
 registerd||registered
 registeration||registration
@@ -1233,17 +1368,21 @@ reloade||reload
 remoote||remote
 remore||remote
 removeable||removable
+repective||respective
 repectively||respectively
 replacable||replaceable
 replacments||replacements
 replys||replies
 reponse||response
 representaion||representation
+repsonse||response
+reqested||requested
 reqeust||request
 reqister||register
 requed||requeued
 requestied||requested
 requiere||require
+requieres||requires
 requirment||requirement
 requred||required
 requried||required
@@ -1254,6 +1393,8 @@ reseting||resetting
 reseved||reserved
 reseverd||reserved
 resizeable||resizable
+resonable||reasonable
+resotre||restore
 resouce||resource
 resouces||resources
 resoures||resources
@@ -1278,6 +1419,7 @@ reuest||request
 reuqest||request
 reutnred||returned
 revsion||revision
+rewritting||rewriting
 rmeoved||removed
 rmeove||remove
 rmeoves||removes
@@ -1286,11 +1428,14 @@ routins||routines
 rquest||request
 runing||running
 runned||ran
+runnnig||running
 runnning||running
 runtine||runtime
 sacrifying||sacrificing
 safly||safely
 safty||safety
+satify||satisfy
+satisifed||satisfied
 savable||saveable
 scaleing||scaling
 scaned||scanned
@@ -1325,9 +1470,11 @@ sequencial||sequential
 serivce||service
 serveral||several
 servive||service
+sesion||session
 setts||sets
 settting||setting
 shapshot||snapshot
+shoft||shift
 shotdown||shutdown
 shoud||should
 shouldnt||shouldn't
@@ -1341,17 +1488,22 @@ similiar||similar
 simlar||similar
 simliar||similar
 simpified||simplified
+simultaneusly||simultaneously
+simultanous||simultaneous
 singaled||signaled
 singal||signal
 singed||signed
+slect||select
 sleeped||slept
 sliped||slipped
 softwade||software
 softwares||software
 soley||solely
+soluation||solution
 souce||source
 speach||speech
 specfic||specific
+specfication||specification
 specfield||specified
 speciefied||specified
 specifc||specific
@@ -1380,6 +1532,7 @@ standart||standard
 standy||standby
 stardard||standard
 staticly||statically
+statisitcs||statistics
 statuss||status
 stoped||stopped
 stoping||stopping
@@ -1398,6 +1551,7 @@ submited||submitted
 submition||submission
 succeded||succeeded
 suceed||succeed
+succesfuly||successfully
 succesfully||successfully
 succesful||successful
 successed||succeeded
@@ -1413,6 +1567,7 @@ suported||supported
 suport||support
 supportet||supported
 suppored||supported
+supporing||supporting
 supportin||supporting
 suppoted||supported
 suppported||supported
@@ -1439,6 +1594,8 @@ syfs||sysfs
 symetric||symmetric
 synax||syntax
 synchonized||synchronized
+sychronization||synchronization
+sychronously||synchronously
 synchronuously||synchronously
 syncronize||synchronize
 syncronized||synchronized
@@ -1447,35 +1604,45 @@ syncronus||synchronous
 syste||system
 sytem||system
 sythesis||synthesis
+tagert||target
 taht||that
+tained||tainted
+tarffic||traffic
 tansmit||transmit
 targetted||targeted
 targetting||targeting
 taskelt||tasklet
 teh||the
+temeprature||temperature
 temorary||temporary
 temproarily||temporarily
 temperture||temperature
-thead||thread
+theads||threads
 therfore||therefore
 thier||their
 threds||threads
 threee||three
 threshhold||threshold
 thresold||threshold
+throtting||throttling
 throught||through
+tansition||transition
 trackling||tracking
 troughput||throughput
 trys||tries
 thses||these
 tiggers||triggers
 tiggered||triggered
+tiggerring||triggering
 tipically||typically
 timeing||timing
+timming||timing
 timout||timeout
 tmis||this
+tolarance||tolerance
 toogle||toggle
 torerable||tolerable
+torlence||tolerance
 traget||target
 traking||tracking
 tramsmitted||transmitted
@@ -1484,17 +1651,22 @@ tranasction||transaction
 tranceiver||transceiver
 tranfer||transfer
 tranmission||transmission
+tranport||transport
 transcevier||transceiver
 transciever||transceiver
 transferd||transferred
 transfered||transferred
 transfering||transferring
 transision||transition
+transistioned||transitioned
 transmittd||transmitted
 transormed||transformed
+trasaction||transaction
 trasfer||transfer
 trasmission||transmission
+trasmitter||transmitter
 treshold||threshold
+trigged||triggered
 triggerd||triggered
 trigerred||triggered
 trigerring||triggering
@@ -1503,13 +1675,17 @@ tunning||tuning
 ture||true
 tyep||type
 udpate||update
+updtes||updates
 uesd||used
+unknwon||unknown
 uknown||unknown
 usccess||success
 uncommited||uncommitted
 uncompatible||incompatible
+uncomressed||uncompressed
 unconditionaly||unconditionally
 undeflow||underflow
+undelying||underlying
 underun||underrun
 unecessary||unnecessary
 unexecpted||unexpected
@@ -1521,6 +1697,7 @@ unexpexted||unexpected
 unfortunatelly||unfortunately
 unifiy||unify
 uniterrupted||uninterrupted
+uninterruptable||uninterruptible
 unintialized||uninitialized
 unitialized||uninitialized
 unkmown||unknown
@@ -1537,13 +1714,17 @@ unneccessary||unnecessary
 unnecesary||unnecessary
 unneedingly||unnecessarily
 unnsupported||unsupported
+unuspported||unsupported
 unmached||unmatched
 unprecise||imprecise
+unpriviledged||unprivileged
+unpriviliged||unprivileged
 unregester||unregister
 unresgister||unregister
 unrgesiter||unregister
 unsinged||unsigned
 unstabel||unstable
+unsolicted||unsolicited
 unsolicitied||unsolicited
 unsuccessfull||unsuccessful
 unsuported||unsupported
@@ -1553,6 +1734,8 @@ unuseful||useless
 unvalid||invalid
 upate||update
 upsupported||unsupported
+upto||up to
+useable||usable
 usefule||useful
 usefull||useful
 usege||usage
@@ -1567,6 +1750,7 @@ utitity||utility
 utitlty||utility
 vaid||valid
 vaild||valid
+validationg||validating
 valide||valid
 variantions||variations
 varible||variable
@@ -1574,9 +1758,12 @@ varient||variant
 vaule||value
 verbse||verbose
 veify||verify
+verfication||verification
 veriosn||version
+versoin||version
 verisons||versions
 verison||version
+veritical||vertical
 verson||version
 vicefersa||vice-versa
 virtal||virtual
@@ -1587,6 +1774,7 @@ vitual||virtual
 volatge||voltage
 vunerable||vulnerable
 wakeus||wakeups
+was't||wasn't
 wathdog||watchdog
 wating||waiting
 wiat||wait
@@ -1597,6 +1785,7 @@ whenver||whenever
 wheter||whether
 whe||when
 wierd||weird
+wihout||without
 wiil||will
 wirte||write
 withing||within
-- 
2.43.0

